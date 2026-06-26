import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/permission_helpers.dart';
import '../../../core/auth/permission_provider.dart';
import '../data/models/bill.dart';
import '../data/models/field_task.dart';
import '../data/providers.dart';
import '../shared/format.dart';
import '../shared/glass_card.dart';
import '../shared/money_text.dart';
import '../shared/state_views.dart';
import '../shared/status_chip.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';
import 'widgets/advance_button.dart';

class TaskDetailScreen extends ConsumerWidget {
  const TaskDetailScreen({super.key, required this.taskId});

  final int taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(taskDetailProvider(taskId));
    final canWrite = ref.watch(hasPermissionProvider(Permissions.tasksWrite));

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: TmColors.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: TmColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go('/tasks'),
        ),
        title: const Text('Tarea'),
        actions: [
          if (canWrite)
            async.maybeWhen(
              data: (task) => IconButton(
                icon: const Icon(Icons.edit_rounded),
                tooltip: 'Editar',
                onPressed: () => context.push('/task/${task.id}/edit'),
              ),
              orElse: () => const SizedBox.shrink(),
            ),
        ],
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: TmColors.backgroundGradient),
        child: SafeArea(
          child: async.when(
            loading: () => const LoadingView(),
            error: (e, _) => ErrorView(
              error: e,
              onRetry: () => ref.invalidate(taskDetailProvider(taskId)),
            ),
            data: (task) => _DetailBody(task: task, canWrite: canWrite),
          ),
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.task, required this.canWrite});

  final FieldTask task;
  final bool canWrite;

  @override
  Widget build(BuildContext context) {
    final showAdvance = canWrite && task.status.nextStatus != null;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              TmSpacing.lg,
              TmSpacing.sm,
              TmSpacing.lg,
              TmSpacing.lg,
            ),
            children: [
              StatusChip(task.status),
              const SizedBox(height: TmSpacing.md),
              Text(task.title, style: TmType.display),
              const SizedBox(height: TmSpacing.md),
              _MetaRow(icon: Icons.place_rounded, text: task.client.name),
              if (task.scheduledAt != null) ...[
                const SizedBox(height: 6),
                _MetaRow(
                  icon: Icons.event_rounded,
                  text: 'Programada · ${formatDayTime(task.scheduledAt!)}',
                ),
              ],
              const SizedBox(height: TmSpacing.lg),
              _SectionCard(
                title: 'Notas',
                child: Text(
                  (task.notes?.isNotEmpty ?? false)
                      ? task.notes!
                      : 'Sin notas.',
                  style: TmType.body.copyWith(
                    color: (task.notes?.isNotEmpty ?? false)
                        ? TmColors.textPrimary
                        : TmColors.textMuted,
                  ),
                ),
              ),
              const SizedBox(height: TmSpacing.md),
              _BillCard(bill: task.bill),
              if (task.startedAt != null || task.completedAt != null) ...[
                const SizedBox(height: TmSpacing.md),
                _TimelineCard(task: task),
              ],
            ],
          ),
        ),
        if (showAdvance)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              TmSpacing.lg,
              0,
              TmSpacing.lg,
              TmSpacing.md,
            ),
            child: AdvanceButton(task: task, expanded: true),
          ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: TmColors.textSecondary),
        const SizedBox(width: 6),
        Expanded(child: Text(text, style: TmType.body)),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: TmType.overline),
          const SizedBox(height: TmSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _BillCard extends StatelessWidget {
  const _BillCard({required this.bill});

  final BillSummary? bill;

  @override
  Widget build(BuildContext context) {
    final bill = this.bill;
    if (bill == null) {
      return GlassCard(
        child: Row(
          children: [
            const Icon(
              Icons.receipt_long_rounded,
              color: TmColors.textMuted,
              size: 18,
            ),
            const SizedBox(width: TmSpacing.sm),
            Text('Sin factura asociada', style: TmType.body),
          ],
        ),
      );
    }
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('FACTURA', style: TmType.overline),
              const SizedBox(width: TmSpacing.sm),
              Text(
                bill.number,
                style: TmType.label.copyWith(color: TmColors.textSecondary),
              ),
              const Spacer(),
              Text(bill.status.toUpperCase(), style: TmType.overline),
            ],
          ),
          const SizedBox(height: TmSpacing.sm),
          MoneyText(bill.total, style: TmType.moneyLg),
          if (bill.lines.isNotEmpty) ...[
            const SizedBox(height: TmSpacing.md),
            Divider(color: TmColors.hairline, height: 1),
            const SizedBox(height: TmSpacing.sm),
            for (final line in bill.lines)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${line.quantity > 1 ? '${line.quantity}× ' : ''}${line.description}',
                        style: TmType.body.copyWith(
                          color: TmColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: TmSpacing.sm),
                    MoneyText(
                      line.total,
                      style: TmType.label.copyWith(
                        color: TmColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.task});

  final FieldTask task;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[
      if (task.startedAt != null)
        _row(
          Icons.bolt_rounded,
          TmColors.statusInProgress,
          'Iniciada',
          formatDayTime(task.startedAt!),
        ),
      if (task.completedAt != null)
        _row(
          Icons.check_circle_rounded,
          TmColors.statusDone,
          'Completada',
          formatDayTime(task.completedAt!),
        ),
    ];
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ACTIVIDAD', style: TmType.overline),
          const SizedBox(height: TmSpacing.sm),
          ...rows,
        ],
      ),
    );
  }

  Widget _row(IconData icon, Color color, String label, String when) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: TmSpacing.sm),
          Text(
            label,
            style: TmType.body.copyWith(color: TmColors.textPrimary),
          ),
          const Spacer(),
          Text(when, style: TmType.label.copyWith(color: TmColors.textMuted)),
        ],
      ),
    );
  }
}
