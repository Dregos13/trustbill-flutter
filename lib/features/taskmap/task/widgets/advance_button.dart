import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/error_messages.dart';
import '../../data/models/field_task.dart';
import '../../data/task_actions.dart';

/// Primary action that advances a task to its next status
/// (Empezar → IN_PROGRESS, Completar → DONE). Hidden for terminal tasks.
class AdvanceButton extends ConsumerStatefulWidget {
  const AdvanceButton({
    super.key,
    required this.task,
    this.expanded = false,
    this.onChanged,
  });

  final FieldTask task;
  final bool expanded;
  final void Function(FieldTask updated)? onChanged;

  @override
  ConsumerState<AdvanceButton> createState() => _AdvanceButtonState();
}

class _AdvanceButtonState extends ConsumerState<AdvanceButton> {
  bool _busy = false;

  Future<void> _advance() async {
    final next = widget.task.status.nextStatus;
    if (next == null) return;
    setState(() => _busy = true);
    try {
      final updated = await ref
          .read(taskActionsProvider)
          .setStatus(widget.task.id, next);
      widget.onChanged?.call(updated);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(friendlyError(e))));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final next = widget.task.status.nextStatus;
    if (next == null) return const SizedBox.shrink();

    final button = FilledButton.icon(
      onPressed: _busy ? null : _advance,
      style: FilledButton.styleFrom(
        backgroundColor: next.color,
        foregroundColor: const Color(0xFF06212E),
      ),
      icon: _busy
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF06212E),
              ),
            )
          : Icon(next.icon, size: 18),
      label: Text(widget.task.status.advanceLabel ?? ''),
    );

    return widget.expanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
