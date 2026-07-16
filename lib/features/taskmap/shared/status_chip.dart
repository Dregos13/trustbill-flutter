import 'package:flutter/material.dart';

import '../data/models/task_status.dart';
import 'tm_spacing.dart';
import 'tm_type.dart';

/// Status pill — color + icon + label (never color-only, for accessibility).
class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key, this.dense = false});

  final TaskStatus status;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final color = status.color;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: dense ? TmSpacing.sm : TmSpacing.md,
        vertical: dense ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(TmRadii.pill),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(status.icon, size: dense ? 12 : 14, color: color),
          const SizedBox(width: 6),
          Text(
            status.label.toUpperCase(),
            style: TmType.overline(context).copyWith(color: color, letterSpacing: 0.8),
          ),
        ],
      ),
    );
  }
}
