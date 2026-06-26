import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/models/field_task.dart';
import '../data/providers.dart';
import '../shared/skeleton.dart';
import '../shared/state_views.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';
import '../task/widgets/advance_button.dart';
import '../task/widgets/task_list_item.dart';

/// Date-bucketed list of tasks. Defaults to open jobs; a toggle widens it to
/// every status. Grouping is client-side (see [_classify]).
class AgendaScreen extends ConsumerStatefulWidget {
  const AgendaScreen({super.key});

  @override
  ConsumerState<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends ConsumerState<AgendaScreen> {
  bool _includeDone = false;

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(agendaTasksProvider(_includeDone));

    Future<void> refresh() async {
      ref.invalidate(agendaTasksProvider(_includeDone));
      await ref.read(agendaTasksProvider(_includeDone).future);
    }

    return DecoratedBox(
      decoration: const BoxDecoration(gradient: TmColors.backgroundGradient),
      child: SafeArea(
        top: false,
        bottom: false,
        child: RefreshIndicator(
          color: TmColors.accent,
          backgroundColor: TmColors.surface,
          onRefresh: refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              TmSpacing.lg,
              TmSpacing.md,
              TmSpacing.lg,
              88,
            ),
            children: [
              _Header(
                includeDone: _includeDone,
                onToggle: (v) => setState(() => _includeDone = v),
              ),
              const SizedBox(height: TmSpacing.lg),
              ...async.when(
                loading: () => const [
                  SkeletonTaskCard(),
                  SizedBox(height: TmSpacing.md),
                  SkeletonTaskCard(),
                  SizedBox(height: TmSpacing.md),
                  SkeletonTaskCard(),
                ],
                error: (e, _) => [
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: ErrorView(
                      error: e,
                      onRetry: () =>
                          ref.invalidate(agendaTasksProvider(_includeDone)),
                    ),
                  ),
                ],
                data: (tasks) => _buildSections(context, tasks),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSections(BuildContext context, List<FieldTask> tasks) {
    if (tasks.isEmpty) {
      return const [
        Padding(
          padding: EdgeInsets.only(top: 24),
          child: EmptyView(
            icon: Icons.event_available_rounded,
            title: 'Agenda despejada',
            subtitle: 'No hay tareas que mostrar.',
          ),
        ),
      ];
    }

    final now = DateTime.now();
    final groups = <_Bucket, List<FieldTask>>{};
    for (final t in tasks) {
      groups.putIfAbsent(_classify(t, now), () => []).add(t);
    }
    for (final list in groups.values) {
      list.sort(_bySchedule);
    }

    final widgets = <Widget>[];
    for (final bucket in _Bucket.values) {
      final list = groups[bucket];
      if (list == null || list.isEmpty) continue;
      widgets.add(
        _SectionHeader(
          label: bucket.label,
          count: list.length,
          accent: bucket.accent,
        ),
      );
      for (final task in list) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: TmSpacing.md),
            child: TaskListItem(
              task: task,
              onTap: () => context.push('/task/${task.id}'),
              trailing: AdvanceButton(task: task),
            ),
          ),
        );
      }
    }
    return widgets;
  }
}

int _bySchedule(FieldTask a, FieldTask b) {
  final as = a.scheduledAt;
  final bs = b.scheduledAt;
  if (as == null && bs == null) return b.id.compareTo(a.id);
  if (as == null) return 1;
  if (bs == null) return -1;
  return as.compareTo(bs);
}

enum _Bucket {
  overdue('Vencidas', true),
  today('Hoy', false),
  tomorrow('Mañana', false),
  week('Esta semana', false),
  later('Más adelante', false),
  noDate('Sin programar', false),
  past('Anteriores', false);

  const _Bucket(this.label, this.accent);
  final String label;
  final bool accent;
}

DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

_Bucket _classify(FieldTask t, DateTime now) {
  final s = t.scheduledAt?.toLocal();
  if (s == null) return _Bucket.noDate;
  if (t.status.isOpen && s.isBefore(now)) return _Bucket.overdue;
  final dayDiff = _startOfDay(s).difference(_startOfDay(now)).inDays;
  if (dayDiff < 0) return _Bucket.past;
  if (dayDiff == 0) return _Bucket.today;
  if (dayDiff == 1) return _Bucket.tomorrow;
  if (dayDiff <= 6) return _Bucket.week;
  return _Bucket.later;
}

class _Header extends StatelessWidget {
  const _Header({required this.includeDone, required this.onToggle});

  final bool includeDone;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TASKMAP', style: TmType.overline),
              const SizedBox(height: 2),
              Text('Agenda', style: TmType.display),
            ],
          ),
        ),
        _Segmented(includeDone: includeDone, onToggle: onToggle),
      ],
    );
  }
}

class _Segmented extends StatelessWidget {
  const _Segmented({required this.includeDone, required this.onToggle});

  final bool includeDone;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: TmColors.surface.withValues(alpha: 0.7),
        borderRadius: TmRadii.brSm,
        border: Border.all(color: TmColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segItem('Abiertas', !includeDone, () => onToggle(false)),
          _segItem('Todas', includeDone, () => onToggle(true)),
        ],
      ),
    );
  }

  Widget _segItem(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? TmColors.accent.withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TmType.label.copyWith(
            color: selected ? TmColors.accent : TmColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.label,
    required this.count,
    required this.accent,
  });

  final String label;
  final int count;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final color = accent ? TmColors.danger : TmColors.textSecondary;
    return Padding(
      padding: const EdgeInsets.only(
        top: TmSpacing.sm,
        bottom: TmSpacing.sm,
      ),
      child: Row(
        children: [
          if (accent) ...[
            const Icon(
              Icons.warning_amber_rounded,
              size: 15,
              color: TmColors.danger,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label.toUpperCase(),
            style: TmType.overline.copyWith(
              color: color,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$count',
            style: TmType.overline.copyWith(color: TmColors.textMuted),
          ),
        ],
      ),
    );
  }
}
