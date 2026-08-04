import 'package:flutter/material.dart';

import '../data/models/field_task.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';

/// Pixel height of one hour row.
const double _kHourH = 56.0;

/// Altura mínima de un bloque. Una tarea de 15 minutos serían 14 px, donde no
/// cabe ni una línea de texto: por debajo de esto se pinta más alto de lo que
/// dura, igual que hace cualquier calendario.
const double _kMinChipH = 22.0;

/// Separación entre bloques que comparten hora, para que se vea el corte.
const double _kColumnGap = 2.0;

/// Width of the left time-label column.
const double _kTimeW = 44.0;

/// Hours displayed (0–23).
const int _kHours = 24;

/// Una tarea colocada en la rejilla: dónde empieza, cuánto ocupa y qué parte
/// del ancho le toca cuando comparte hora con otras.
class PlacedTask {
  const PlacedTask({
    required this.task,
    required this.top,
    required this.height,
    required this.column,
    required this.columns,
  });

  final FieldTask task;
  final double top;
  final double height;

  /// Columna que ocupa dentro de su grupo de solape, y cuántas hay en total.
  final int column;
  final int columns;
}

/// Reparte las tareas de un día en columnas para que las que se solapan se
/// vean todas, en vez de taparse unas a otras.
///
/// El reparto es por grupos: se recorren las tareas ordenadas por hora y se
/// acumula un grupo mientras alguna siga abierta. Dentro de cada grupo, cada
/// tarea va a la primera columna que ya haya quedado libre. Así dos tareas
/// consecutivas que no se pisan siguen ocupando el ancho entero, y solo se
/// parte el ancho donde de verdad hay solape.
///
/// Función pura y de nivel de librería: se puede probar sin montar widgets.
@visibleForTesting
List<PlacedTask> layoutDayTasks(List<FieldTask> tasks) {
  final scheduled = tasks.where((t) => t.scheduledAt != null).toList()
    ..sort((a, b) => a.scheduledAt!.compareTo(b.scheduledAt!));
  if (scheduled.isEmpty) return const [];

  final placed = <PlacedTask>[];

  // Índice donde empieza el grupo actual y hora de fin más lejana del grupo.
  var groupStart = 0;
  DateTime? groupEnd;
  // Fin de la última tarea de cada columna del grupo actual.
  final columnEnds = <DateTime>[];
  final columnOf = <int>[];

  void flushGroup(int endExclusive) {
    for (var i = groupStart; i < endExclusive; i++) {
      final task = scheduled[i];
      final start = task.scheduledAt!.toLocal();
      final minutes = task.durationMinutes.toDouble();
      placed.add(
        PlacedTask(
          task: task,
          top: (start.hour + start.minute / 60.0) * _kHourH,
          height: (minutes / 60.0 * _kHourH).clamp(_kMinChipH, _kHours * _kHourH),
          column: columnOf[i - groupStart],
          columns: columnEnds.length,
        ),
      );
    }
  }

  for (var i = 0; i < scheduled.length; i++) {
    final task = scheduled[i];
    final start = task.scheduledAt!.toLocal();
    final end = task.endsAt!.toLocal();

    // ¿Empieza un grupo nuevo? Solo si no pisa a NINGUNA de las anteriores.
    if (groupEnd != null && !start.isBefore(groupEnd)) {
      flushGroup(i);
      groupStart = i;
      columnEnds.clear();
      columnOf.clear();
      groupEnd = null;
    }

    var column = columnEnds.indexWhere((e) => !start.isBefore(e));
    if (column == -1) {
      columnEnds.add(end);
      column = columnEnds.length - 1;
    } else {
      columnEnds[column] = end;
    }
    columnOf.add(column);
    groupEnd = groupEnd == null || end.isAfter(groupEnd) ? end : groupEnd;
  }
  flushGroup(scheduled.length);

  return placed;
}

/// A Google-Calendar-style week grid. Swipe horizontally to change weeks.
/// Tapping an empty slot calls [onSlotTap] with the DateTime for that hour.
/// Tapping a task chip calls [onTaskTap].
class CalendarWeekView extends StatefulWidget {
  const CalendarWeekView({
    super.key,
    required this.tasks,
    required this.onSlotTap,
    required this.onTaskTap,
  });

  final List<FieldTask> tasks;
  final void Function(DateTime) onSlotTap;
  final void Function(FieldTask) onTaskTap;

  @override
  State<CalendarWeekView> createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> {
  /// Page 1000 = current week (gives ~19 years of scrolling in each direction).
  static const int _kInitialPage = 1000;
  late final PageController _pages;
  late final ScrollController _scroll;
  int _currentPage = _kInitialPage;

  @override
  void initState() {
    super.initState();
    _pages = PageController(initialPage: _kInitialPage);
    // Scroll to 7 AM on init.
    _scroll = ScrollController(initialScrollOffset: _kHourH * 7);
  }

  @override
  void dispose() {
    _pages.dispose();
    _scroll.dispose();
    super.dispose();
  }

  /// Monday of the week for [page].
  DateTime _mondayOf(int page) {
    final now = DateTime.now();
    final todayMonday = now.subtract(Duration(days: now.weekday - 1));
    final base = DateTime(todayMonday.year, todayMonday.month, todayMonday.day);
    return base.add(Duration(days: (page - _kInitialPage) * 7));
  }

  /// Returns map: dayIndex (0=Mon…6=Sun) → tasks that have scheduledAt on that day.
  Map<int, List<FieldTask>> _tasksByDay(DateTime monday) {
    final result = <int, List<FieldTask>>{};
    for (final t in widget.tasks) {
      final s = t.scheduledAt?.toLocal();
      if (s == null) continue;
      final day = DateTime(s.year, s.month, s.day);
      for (var i = 0; i < 7; i++) {
        final col = monday.add(Duration(days: i));
        if (day == DateTime(col.year, col.month, col.day)) {
          result.putIfAbsent(i, () => []).add(t);
          break;
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _WeekNav(
          monday: _mondayOf(_currentPage),
          onPrev: () => _pages.previousPage(
              duration: const Duration(milliseconds: 250), curve: Curves.easeInOut),
          onNext: () => _pages.nextPage(
              duration: const Duration(milliseconds: 250), curve: Curves.easeInOut),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pages,
            onPageChanged: (p) => setState(() => _currentPage = p),
            itemBuilder: (_, page) {
              final monday = _mondayOf(page);
              final byDay = _tasksByDay(monday);
              return _WeekPage(
                monday: monday,
                tasksByDay: byDay,
                scroll: _scroll,
                onSlotTap: widget.onSlotTap,
                onTaskTap: widget.onTaskTap,
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── Week navigation header ────────────────────────────────────────────────────

class _WeekNav extends StatelessWidget {
  const _WeekNav({required this.monday, required this.onPrev, required this.onNext});

  final DateTime monday;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final sunday = monday.add(const Duration(days: 6));
    final sameMonth = monday.month == sunday.month;
    final label = sameMonth
        ? '${_monthName(monday.month)} ${monday.year}'
        : '${_monthName(monday.month)} – ${_monthName(sunday.month)} ${sunday.year}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TmSpacing.md, vertical: TmSpacing.sm),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.chevron_left, color: context.tm.textSecondary),
            onPressed: onPrev,
            visualDensity: VisualDensity.compact,
          ),
          Expanded(
            child: Text(label, style: TmType.h2(context), textAlign: TextAlign.center),
          ),
          IconButton(
            icon: Icon(Icons.chevron_right, color: context.tm.textSecondary),
            onPressed: onNext,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  static String _monthName(int m) => const [
    '', 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
    'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
  ][m];
}

// ── Single week page ──────────────────────────────────────────────────────────

class _WeekPage extends StatelessWidget {
  const _WeekPage({
    required this.monday,
    required this.tasksByDay,
    required this.scroll,
    required this.onSlotTap,
    required this.onTaskTap,
  });

  final DateTime monday;
  final Map<int, List<FieldTask>> tasksByDay;
  final ScrollController scroll;
  final void Function(DateTime) onSlotTap;
  final void Function(FieldTask) onTaskTap;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = List.generate(7, (i) => monday.add(Duration(days: i)));

    return Column(
      children: [
        // Day header row
        Row(
          children: [
            SizedBox(width: _kTimeW),
            ...days.map((d) {
              final isToday = d.year == today.year &&
                  d.month == today.month &&
                  d.day == today.day;
              return Expanded(child: _DayHeader(date: d, isToday: isToday));
            }),
          ],
        ),
        Divider(height: 1, color: context.tm.glassBorder),
        // Scrollable time grid
        Expanded(
          child: SingleChildScrollView(
            controller: scroll,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time labels
                SizedBox(
                  width: _kTimeW,
                  child: Column(
                    children: List.generate(_kHours, (h) => _TimeLabel(hour: h)),
                  ),
                ),
                // Day columns
                ...List.generate(7, (i) {
                  final day = days[i];
                  final isToday = day.year == today.year &&
                      day.month == today.month &&
                      day.day == today.day;
                  return Expanded(
                    child: _DayColumn(
                      date: day,
                      isToday: isToday,
                      tasks: tasksByDay[i] ?? [],
                      onSlotTap: onSlotTap,
                      onTaskTap: onTaskTap,
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Day header ────────────────────────────────────────────────────────────────

class _DayHeader extends StatelessWidget {
  const _DayHeader({required this.date, required this.isToday});

  final DateTime date;
  final bool isToday;

  static const _dayNames = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _dayNames[date.weekday - 1],
          style: TmType.label(context).copyWith(color: isToday ? context.tm.accent : context.tm.textMuted),
        ),
        const SizedBox(height: 2),
        Container(
          width: 28,
          height: 28,
          decoration: isToday
              ? BoxDecoration(color: context.tm.accent, shape: BoxShape.circle)
              : null,
          alignment: Alignment.center,
          child: Text(
            '${date.day}',
            style: TmType.body(context).copyWith(
              fontWeight: FontWeight.w700,
              color: isToday ? context.tm.surface : context.tm.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: TmSpacing.xs),
      ],
    );
  }
}

// ── Time label ────────────────────────────────────────────────────────────────

class _TimeLabel extends StatelessWidget {
  const _TimeLabel({required this.hour});
  final int hour;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kHourH,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 6, top: 2),
          child: Text(
            hour == 0 ? '' : '${hour.toString().padLeft(2, '0')}:00',
            style: TmType.label(context).copyWith(color: context.tm.textMuted, fontSize: 10),
          ),
        ),
      ),
    );
  }
}

// ── Day column ────────────────────────────────────────────────────────────────

class _DayColumn extends StatelessWidget {
  const _DayColumn({
    required this.date,
    required this.isToday,
    required this.tasks,
    required this.onSlotTap,
    required this.onTaskTap,
  });

  final DateTime date;
  final bool isToday;
  final List<FieldTask> tasks;
  final void Function(DateTime) onSlotTap;
  final void Function(FieldTask) onTaskTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hour cells (tappable background)
        Column(
          children: List.generate(_kHours, (h) {
            final slotTime = DateTime(date.year, date.month, date.day, h);
            return GestureDetector(
              onTap: () => onSlotTap(slotTime),
              child: Container(
                height: _kHourH,
                decoration: BoxDecoration(
                  color: isToday
                      ? context.tm.accent.withValues(alpha: 0.04)
                      : Colors.transparent,
                  border: Border(
                    top: BorderSide(color: context.tm.hairline, width: 0.5),
                    left: BorderSide(color: context.tm.glassBorder, width: 0.5),
                  ),
                ),
              ),
            );
          }),
        ),
        // Bloques encima, con la altura de su duración real y repartidos en
        // columnas cuando se solapan.
        LayoutBuilder(
          builder: (context, constraints) {
            final ancho = constraints.maxWidth - 4;
            return Stack(
              children: layoutDayTasks(tasks).map((p) {
                final anchoColumna = ancho / p.columns;
                return Positioned(
                  // Key por id: las pruebas de integracion localizan el bloque
                  // y miden su rectangulo real, sin adivinar coordenadas.
                  key: Key('task-chip-${p.task.id}'),
                  top: p.top + 1,
                  left: 2 + p.column * anchoColumna,
                  width: anchoColumna - (p.columns > 1 ? _kColumnGap : 0),
                  height: p.height - 2,
                  child: GestureDetector(
                    onTap: () => onTaskTap(p.task),
                    child: _TaskChip(task: p.task, compacto: p.height < 34),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

// ── Task chip ─────────────────────────────────────────────────────────────────

class _TaskChip extends StatelessWidget {
  const _TaskChip({required this.task, this.compacto = false});
  final FieldTask task;

  /// Bloque tan bajo que solo cabe el título, sin la hora debajo.
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final color = task.status.color;
    final inicio = task.scheduledAt?.toLocal();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: compacto ? 1 : 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      // ClipRect: la altura la manda la duración, así que el texto que no
      // quepa se recorta en vez de desbordar sobre el bloque siguiente.
      child: ClipRect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              task.title,
              style: TmType.label(
                context,
              ).copyWith(color: color, fontSize: 10, height: 1.2),
              maxLines: compacto ? 1 : 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (!compacto && inicio != null)
              Text(
                '${_dosDigitos(inicio.hour)}:${_dosDigitos(inicio.minute)}'
                ' · ${_duracionCorta(task.durationMinutes)}',
                style: TmType.label(context).copyWith(
                  color: color.withValues(alpha: 0.75),
                  fontSize: 9,
                  height: 1.1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}

String _dosDigitos(int n) => n.toString().padLeft(2, '0');

/// "1 h 30", "45 min", "2 h" — corto porque el bloque es estrecho.
String _duracionCorta(int minutos) {
  final horas = minutos ~/ 60;
  final resto = minutos % 60;
  if (horas == 0) return '$resto min';
  if (resto == 0) return '$horas h';
  return '$horas h $resto';
}
