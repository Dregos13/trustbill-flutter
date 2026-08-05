import 'package:flutter/material.dart';

import '../data/models/field_task.dart';
import '../shared/task_palette.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';

/// Altura de una hora, por defecto. El usuario puede agrandarla desde la
/// cabecera; se pasa como parámetro para que el reparto siga siendo probable
/// sin montar widgets.
const double kDefaultHourHeight = 56.0;

/// Límites del zoom. Por debajo de 40 no cabe el texto ni de una tarea larga;
/// por encima de 200 el día deja de verse de un vistazo y hay que hacer mucho
/// scroll para nada.
const double kMinHourHeight = 40.0;
const double kMaxHourHeight = 200.0;
const double _kZoomStep = 32.0;

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

/// Cuántos días se ven a la vez. En un móvil, siete columnas dejan ~110 px por
/// día y el título no cabe por ANCHO, no por alto: por eso el zoom vertical
/// solo no arregla la legibilidad y hace falta poder estrechar el rango.
const List<int> kDaySpans = [7, 3, 1];

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
List<PlacedTask> layoutDayTasks(
  List<FieldTask> tasks, {
  double hourHeight = kDefaultHourHeight,
}) {
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
          top: (start.hour + start.minute / 60.0) * hourHeight,
          height: (minutes / 60.0 * hourHeight).clamp(
            _kMinChipH,
            _kHours * hourHeight,
          ),
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

/// Rejilla de agenda estilo Google Calendar. Se desliza en horizontal para
/// cambiar de periodo; el periodo son 7, 3 o 1 días según el selector.
/// Tocar un hueco vacío llama a [onSlotTap]; tocar un bloque, a [onTaskTap].
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
  /// Página 1000 = periodo actual (deja ~19 años hacia cada lado).
  static const int _kInitialPage = 1000;
  PageController _pages = PageController(initialPage: _kInitialPage);
  late final ScrollController _scroll;
  int _currentPage = _kInitialPage;

  int _dayCount = kDaySpans.first;
  double _hourHeight = kDefaultHourHeight;

  @override
  void initState() {
    super.initState();
    // Arrancar en la hora actual, no a las 7:00 fijas. Lo que quieres ver al
    // abrir la agenda es lo que tienes ahora, no la madrugada; se deja una
    // hora de margen por encima para ver lo que acaba de pasar.
    final ahora = DateTime.now();
    final desde = (ahora.hour - 1).clamp(0, _kHours - 1);
    _scroll = ScrollController(initialScrollOffset: kDefaultHourHeight * desde);
  }

  @override
  void dispose() {
    _pages.dispose();
    _scroll.dispose();
    super.dispose();
  }

  /// Primer día de la página. Con semana completa se ancla al lunes; con 3 días
  /// o 1, a hoy, que es lo que el usuario espera al estrechar el rango.
  DateTime _startOfPage(int page) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final anchor = _dayCount == 7
        ? today.subtract(Duration(days: now.weekday - 1))
        : today;
    return anchor.add(Duration(days: (page - _kInitialPage) * _dayCount));
  }

  /// Cambiar el número de días reinicia la paginación al periodo actual: la
  /// página 1000 pasa a significar otra cosa, así que quedarse donde estabas
  /// te dejaría en una fecha aleatoria.
  void _setDayCount(int days) {
    if (days == _dayCount) return;
    final anterior = _pages;
    setState(() {
      _dayCount = days;
      _currentPage = _kInitialPage;
      _pages = PageController(initialPage: _kInitialPage);
    });
    // Se libera después del frame: el PageView todavía lo tiene montado.
    WidgetsBinding.instance.addPostFrameCallback((_) => anterior.dispose());
  }

  void _zoom(double delta) {
    final anterior = _hourHeight;
    final nueva = (anterior + delta).clamp(kMinHourHeight, kMaxHourHeight);
    if (nueva == anterior) return;
    setState(() => _hourHeight = nueva);

    // Mantener la MISMA hora en pantalla. El scroll guarda píxeles, no horas:
    // sin reescalarlo, ampliar te manda a la madrugada porque el mismo offset
    // pasa a significar una hora mucho más temprana.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      final destino = _scroll.offset * nueva / anterior;
      _scroll.jumpTo(destino.clamp(0.0, _scroll.position.maxScrollExtent));
    });
  }

  /// Tareas por índice de día dentro del periodo que empieza en [start].
  Map<int, List<FieldTask>> _tasksByDay(DateTime start) {
    final result = <int, List<FieldTask>>{};
    for (final t in widget.tasks) {
      final s = t.scheduledAt?.toLocal();
      if (s == null) continue;
      final day = DateTime(s.year, s.month, s.day);
      final diff = day.difference(start).inDays;
      if (diff >= 0 && diff < _dayCount) {
        result.putIfAbsent(diff, () => []).add(t);
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CalendarNav(
          start: _startOfPage(_currentPage),
          dayCount: _dayCount,
          hourHeight: _hourHeight,
          onPrev: () => _pages.previousPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
          onNext: () => _pages.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
          onDayCount: _setDayCount,
          onZoomIn: () => _zoom(_kZoomStep),
          onZoomOut: () => _zoom(-_kZoomStep),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pages,
            onPageChanged: (p) => setState(() => _currentPage = p),
            itemBuilder: (_, page) {
              final start = _startOfPage(page);
              return _GridPage(
                start: start,
                dayCount: _dayCount,
                hourHeight: _hourHeight,
                tasksByDay: _tasksByDay(start),
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

// ── Cabecera: periodo, rango de días y zoom ──────────────────────────────────

class _CalendarNav extends StatelessWidget {
  const _CalendarNav({
    required this.start,
    required this.dayCount,
    required this.hourHeight,
    required this.onPrev,
    required this.onNext,
    required this.onDayCount,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  final DateTime start;
  final int dayCount;
  final double hourHeight;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final void Function(int) onDayCount;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  static const _dayNames = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  String get _label {
    final end = start.add(Duration(days: dayCount - 1));
    if (dayCount == 1) {
      return '${_dayNames[start.weekday - 1]} ${start.day} ${_monthName(start.month)}';
    }
    if (start.month == end.month) {
      return dayCount == 7
          ? '${_monthName(start.month)} ${start.year}'
          : '${start.day}–${end.day} ${_monthName(start.month)}';
    }
    return '${start.day} ${_monthName(start.month)} – ${end.day} ${_monthName(end.month)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onPrev,
              icon: const Icon(Icons.chevron_left_rounded),
              color: context.tm.textSecondary,
            ),
            Expanded(
              child: Text(
                _label,
                textAlign: TextAlign.center,
                style: TmType.title(context),
              ),
            ),
            IconButton(
              onPressed: onNext,
              icon: const Icon(Icons.chevron_right_rounded),
              color: context.tm.textSecondary,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: TmSpacing.md,
            right: TmSpacing.md,
            bottom: TmSpacing.xs,
          ),
          child: Row(
            children: [
              _DaySpanSelector(value: dayCount, onChanged: onDayCount),
              const Spacer(),
              _ZoomButton(
                key: const Key('calendar-zoom-out'),
                icon: Icons.zoom_out_rounded,
                tooltip: 'Ver más horas',
                onTap: hourHeight > kMinHourHeight ? onZoomOut : null,
              ),
              const SizedBox(width: 4),
              _ZoomButton(
                key: const Key('calendar-zoom-in'),
                icon: Icons.zoom_in_rounded,
                tooltip: 'Agrandar las tareas',
                onTap: hourHeight < kMaxHourHeight ? onZoomIn : null,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static String _monthName(int m) => const [
    '',
    'Ene',
    'Feb',
    'Mar',
    'Abr',
    'May',
    'Jun',
    'Jul',
    'Ago',
    'Sep',
    'Oct',
    'Nov',
    'Dic',
  ][m];
}

class _DaySpanSelector extends StatelessWidget {
  const _DaySpanSelector({required this.value, required this.onChanged});

  final int value;
  final void Function(int) onChanged;

  static const _labels = {7: 'Semana', 3: '3 días', 1: 'Día'};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.tm.glassFill,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.tm.glassBorder),
      ),
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: kDaySpans.map((d) {
          final selected = d == value;
          return GestureDetector(
            key: Key('calendar-span-$d'),
            onTap: () => onChanged(d),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: selected ? context.tm.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                _labels[d]!,
                style: TmType.label(context).copyWith(
                  color: selected
                      ? context.tm.surface
                      : context.tm.textSecondary,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: context.tm.glassFill,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.tm.glassBorder),
          ),
          child: Icon(
            icon,
            size: 18,
            color: enabled ? context.tm.textSecondary : context.tm.textMuted,
          ),
        ),
      ),
    );
  }
}

// ── Una página de la rejilla ─────────────────────────────────────────────────

class _GridPage extends StatelessWidget {
  const _GridPage({
    required this.start,
    required this.dayCount,
    required this.hourHeight,
    required this.tasksByDay,
    required this.scroll,
    required this.onSlotTap,
    required this.onTaskTap,
  });

  final DateTime start;
  final int dayCount;
  final double hourHeight;
  final Map<int, List<FieldTask>> tasksByDay;
  final ScrollController scroll;
  final void Function(DateTime) onSlotTap;
  final void Function(FieldTask) onTaskTap;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = List.generate(dayCount, (i) => start.add(Duration(days: i)));
    bool esHoy(DateTime d) =>
        d.year == today.year && d.month == today.month && d.day == today.day;

    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: _kTimeW),
            ...days.map(
              (d) => Expanded(
                child: _DayHeader(date: d, isToday: esHoy(d)),
              ),
            ),
          ],
        ),
        Divider(height: 1, color: context.tm.glassBorder),
        Expanded(
          child: SingleChildScrollView(
            controller: scroll,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _kTimeW,
                  child: Column(
                    children: List.generate(
                      _kHours,
                      (h) => _TimeLabel(hour: h, hourHeight: hourHeight),
                    ),
                  ),
                ),
                ...List.generate(dayCount, (i) {
                  final day = days[i];
                  return Expanded(
                    child: _DayColumn(
                      date: day,
                      isToday: esHoy(day),
                      hourHeight: hourHeight,
                      tasks: tasksByDay[i] ?? const [],
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
          style: TmType.label(
            context,
          ).copyWith(color: isToday ? context.tm.accent : context.tm.textMuted),
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
  const _TimeLabel({required this.hour, required this.hourHeight});
  final int hour;
  final double hourHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hourHeight,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 6, top: 2),
          child: Text(
            hour == 0 ? '' : '${hour.toString().padLeft(2, '0')}:00',
            style: TmType.label(
              context,
            ).copyWith(color: context.tm.textMuted, fontSize: 10),
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
    required this.hourHeight,
    required this.tasks,
    required this.onSlotTap,
    required this.onTaskTap,
  });

  final DateTime date;
  final bool isToday;
  final double hourHeight;
  final List<FieldTask> tasks;
  final void Function(DateTime) onSlotTap;
  final void Function(FieldTask) onTaskTap;

  @override
  Widget build(BuildContext context) {
    final ahora = DateTime.now();
    final esFinDeSemana = date.weekday >= DateTime.saturday;
    // Minutos transcurridos del día de hoy, para la línea de "ahora" y para
    // saber qué horas ya han pasado.
    final minutosAhora = ahora.hour * 60 + ahora.minute;
    final finDelDia = DateTime(date.year, date.month, date.day, 23, 59);
    final diaPasado = finDelDia.isBefore(ahora);

    return Stack(
      children: [
        // Hour cells (tappable background)
        Column(
          children: List.generate(_kHours, (h) {
            final slotTime = DateTime(date.year, date.month, date.day, h);
            // Lo que ya pasó se apaga un poco: el día se lee de un vistazo
            // sin tener que buscar dónde estás.
            final yaPaso = diaPasado || (isToday && h < ahora.hour);
            return GestureDetector(
              onTap: () => onSlotTap(slotTime),
              child: Container(
                height: hourHeight,
                decoration: BoxDecoration(
                  color: yaPaso
                      ? context.tm.textMuted.withValues(alpha: 0.05)
                      : isToday
                      ? context.tm.accent.withValues(alpha: 0.04)
                      : esFinDeSemana
                      ? context.tm.textMuted.withValues(alpha: 0.03)
                      : Colors.transparent,
                  border: Border(
                    // Las líneas de hora en punto pesan un poco más que el
                    // resto de la rejilla, que antes competía con el contenido.
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
        //
        // Positioned.fill NO es decorativo: un hijo sin posicionar recibe
        // constraints holgadas, y un Stack cuyos hijos son TODOS Positioned no
        // tiene de quién sacar su tamaño, así que se encoge a cero y los
        // bloques desaparecen sin dar ningún error. La rejilla se seguía
        // viendo y el calendario salía vacío.
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final ancho = constraints.maxWidth - 4;
              return Stack(
                children: layoutDayTasks(tasks, hourHeight: hourHeight).map((
                  p,
                ) {
                  final anchoColumna = ancho / p.columns;
                  return Positioned(
                    // Key por id: las pruebas localizan el bloque y miden su
                    // rectangulo real, sin adivinar coordenadas.
                    key: Key('task-chip-${p.task.id}'),
                    top: p.top + 1,
                    left: 2 + p.column * anchoColumna,
                    width: anchoColumna - (p.columns > 1 ? _kColumnGap : 0),
                    height: p.height - 2,
                    child: GestureDetector(
                      onTap: () => onTaskTap(p.task),
                      child: _TaskChip(task: p.task, alto: p.height),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),

        // Línea de "ahora". Es lo que más ayuda a situarse de un vistazo: sin
        // ella hay que leer las etiquetas de hora y comparar mentalmente.
        // Va la última para quedar por encima de los bloques.
        if (isToday)
          Positioned(
            top: (minutosAhora / 60.0) * hourHeight - 1,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: context.tm.danger,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(height: 1.5, color: context.tm.danger),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

// ── Task chip ─────────────────────────────────────────────────────────────────

class _TaskChip extends StatelessWidget {
  const _TaskChip({required this.task, required this.alto});

  final FieldTask task;

  /// Altura real del bloque: decide cuánta información cabe dentro.
  final double alto;

  @override
  Widget build(BuildContext context) {
    final estilo = chipStyleFor(task);
    final inicio = task.scheduledAt?.toLocal();

    // Cuánto cabe: solo título / título + hora / y además el cliente.
    final compacto = alto < 34;
    final cabeCliente = alto >= 62 && task.client != null;

    return Container(
      decoration: BoxDecoration(
        color: estilo.fill,
        border: Border.all(color: estilo.border, width: 0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      // ClipRRect: la altura la manda la duración, así que lo que no quepa se
      // recorta en vez de desbordar sobre el bloque siguiente. Y respeta el
      // radio, para que la barra de color no se salga por las esquinas.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barra de color a la izquierda: el tono del cliente se identifica
            // de un vistazo aunque el bloque sea estrecho, y así el borde
            // puede ser mucho más discreto sin perder la señal.
            //
            // Va como widget y no como BorderSide porque un Border con lados
            // de distinto color no admite borderRadius: revienta al pintar.
            // Lo cazaron los tests de render.
            Container(width: 3, color: estilo.base),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  4,
                  compacto ? 1 : 3,
                  4,
                  compacto ? 1 : 3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      estilo.check ? '✓ ${task.title}' : task.title,
                      style: TmType.label(context).copyWith(
                        color: estilo.text,
                        fontSize: 10,
                        height: 1.2,
                        decoration: estilo.strikeThrough
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                      maxLines: compacto ? 1 : 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!compacto && inicio != null)
                      Text(
                        '${_dosDigitos(inicio.hour)}:${_dosDigitos(inicio.minute)}'
                        ' · ${_duracionCorta(task.durationMinutes)}',
                        style: TmType.label(context).copyWith(
                          color: estilo.text.withValues(alpha: 0.75),
                          fontSize: 9,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (cabeCliente)
                      Text(
                        task.client!.name,
                        style: TmType.label(context).copyWith(
                          color: estilo.text.withValues(alpha: 0.75),
                          fontSize: 9,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
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
