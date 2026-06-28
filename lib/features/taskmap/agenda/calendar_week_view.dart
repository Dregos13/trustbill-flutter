import 'package:flutter/material.dart';

import '../data/models/field_task.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';

/// Pixel height of one hour row.
const double _kHourH = 56.0;

/// Width of the left time-label column.
const double _kTimeW = 44.0;

/// Hours displayed (0–23).
const int _kHours = 24;

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
            icon: const Icon(Icons.chevron_left, color: TmColors.textSecondary),
            onPressed: onPrev,
            visualDensity: VisualDensity.compact,
          ),
          Expanded(
            child: Text(label, style: TmType.h2, textAlign: TextAlign.center),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: TmColors.textSecondary),
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
        Divider(height: 1, color: TmColors.glassBorder),
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
          style: TmType.label.copyWith(color: isToday ? TmColors.accent : TmColors.textMuted),
        ),
        const SizedBox(height: 2),
        Container(
          width: 28,
          height: 28,
          decoration: isToday
              ? const BoxDecoration(color: TmColors.accent, shape: BoxShape.circle)
              : null,
          alignment: Alignment.center,
          child: Text(
            '${date.day}',
            style: TmType.body.copyWith(
              fontWeight: FontWeight.w700,
              color: isToday ? TmColors.bg : TmColors.textPrimary,
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
            style: TmType.label.copyWith(color: TmColors.textMuted, fontSize: 10),
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
                      ? TmColors.accent.withValues(alpha: 0.04)
                      : Colors.transparent,
                  border: Border(
                    top: BorderSide(color: TmColors.hairline, width: 0.5),
                    left: BorderSide(color: TmColors.glassBorder, width: 0.5),
                  ),
                ),
              ),
            );
          }),
        ),
        // Task chips overlaid
        ...tasks.map((t) {
          final s = t.scheduledAt!.toLocal();
          final top = (s.hour + s.minute / 60.0) * _kHourH;
          return Positioned(
            top: top + 2,
            left: 2,
            right: 2,
            child: GestureDetector(
              onTap: () => onTaskTap(t),
              child: _TaskChip(task: t),
            ),
          );
        }),
      ],
    );
  }
}

// ── Task chip ─────────────────────────────────────────────────────────────────

class _TaskChip extends StatelessWidget {
  const _TaskChip({required this.task});
  final FieldTask task;

  @override
  Widget build(BuildContext context) {
    final color = task.status.color;
    return Container(
      constraints: const BoxConstraints(minHeight: 22),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        border: Border.all(color: color.withValues(alpha: 0.6), width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        task.title,
        style: TmType.label.copyWith(color: color, fontSize: 10, height: 1.2),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
