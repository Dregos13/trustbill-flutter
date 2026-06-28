import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/field_task.dart';
import '../data/models/task_status.dart';
import '../data/providers.dart';
import '../shared/state_views.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';
import '../task/widgets/advance_button.dart';
import '../task/widgets/task_list_item.dart';

/// Bottom sheet listing a client's field tasks (opened from a map pin).
class ClientTasksSheet extends ConsumerWidget {
  const ClientTasksSheet({
    super.key,
    required this.clientId,
    required this.clientName,
    required this.latitude,
    required this.longitude,
  });

  final int clientId;
  final String clientName;
  final double latitude;
  final double longitude;

  Future<void> _openInMaps(BuildContext context) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude',
    );
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir Google Maps')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir Google Maps')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(clientTasksProvider(clientId));
    return _SheetShell(
      title: clientName,
      action: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: () => _openInMaps(context),
          icon: const Icon(Icons.directions_rounded, size: 18),
          label: const Text('Cómo llegar'),
          style: OutlinedButton.styleFrom(
            foregroundColor: TmColors.accent,
            side: BorderSide(color: TmColors.glassBorder),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
      child: tasksAsync.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(TmSpacing.xl),
          child: LoadingView(),
        ),
        error: (e, _) => Padding(
          padding: const EdgeInsets.all(TmSpacing.lg),
          child: ErrorView(
            error: e,
            onRetry: () => ref.invalidate(clientTasksProvider(clientId)),
          ),
        ),
        data: (tasks) {
          if (tasks.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(TmSpacing.xl),
              child: EmptyView(icon: Icons.inbox_rounded, title: 'Sin tareas'),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: _buildGrouped(context, tasks),
          );
        },
      ),
    );
  }
}

List<Widget> _buildGrouped(BuildContext context, List<FieldTask> tasks) {
  const order = [TaskStatus.inProgress, TaskStatus.pending, TaskStatus.done, TaskStatus.cancelled];
  final groups = <TaskStatus, List<FieldTask>>{};
  for (final t in tasks) {
    groups.putIfAbsent(t.status, () => []).add(t);
  }

  final widgets = <Widget>[];
  for (final status in order) {
    final group = groups[status];
    if (group == null || group.isEmpty) continue;
    if (widgets.isNotEmpty) {
      widgets.add(Divider(color: TmColors.glassBorder, height: TmSpacing.lg));
    }
    widgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: TmSpacing.sm),
        child: Row(
          children: [
            Icon(status.icon, size: 13, color: status.color),
            const SizedBox(width: 5),
            Text(status.label, style: TmType.label.copyWith(color: status.color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
    for (final task in group) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: TmSpacing.md),
          child: TaskListItem(
            task: task,
            showClient: false,
            onTap: () {
              Navigator.of(context).pop();
              context.push('/task/${task.id}');
            },
            trailing: AdvanceButton(task: task),
          ),
        ),
      );
    }
  }
  return widgets;
}

class _SheetShell extends StatelessWidget {
  const _SheetShell({required this.title, required this.child, this.action});

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.7;
    return Container(
      decoration: BoxDecoration(
        color: TmColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(TmRadii.xl),
        ),
        border: Border(top: BorderSide(color: TmColors.glassBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            TmSpacing.lg,
            TmSpacing.md,
            TmSpacing.lg,
            TmSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: TmColors.glassBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: TmSpacing.md),
              Row(
                children: [
                  const Icon(
                    Icons.place_rounded,
                    color: TmColors.accent,
                    size: 20,
                  ),
                  const SizedBox(width: TmSpacing.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: TmType.h2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (action != null) ...[
                const SizedBox(height: TmSpacing.md),
                action!,
              ],
              const SizedBox(height: TmSpacing.lg),
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: SingleChildScrollView(child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
