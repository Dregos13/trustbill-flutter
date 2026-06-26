import 'package:flutter/material.dart';

import '../../data/models/map_client.dart';
import '../../shared/tm_colors.dart';

/// Glowing circular pin for a client. Color = dominant status; shows the task
/// count (or the status icon when there's a single task).
class TaskPin extends StatelessWidget {
  const TaskPin({super.key, required this.client, required this.onTap});

  final MapClient client;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final status = client.counts.dominantStatus;
    final color = status.color;
    final count = client.counts.total;

    return Semantics(
      button: true,
      label: '${client.name}: $count tarea${count == 1 ? '' : 's'}',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: TmColors.bg.withValues(alpha: 0.92),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2.2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.55),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: count > 1
              ? Text(
                  '$count',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                )
              : Icon(status.icon, color: color, size: 18),
        ),
      ),
    );
  }
}

/// Cluster bubble — accent ring + count badge.
class ClusterBadge extends StatelessWidget {
  const ClusterBadge({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TmColors.bg.withValues(alpha: 0.92),
        shape: BoxShape.circle,
        border: Border.all(color: TmColors.accent, width: 2.4),
        boxShadow: [
          BoxShadow(
            color: TmColors.accent.withValues(alpha: 0.5),
            blurRadius: 16,
            spreadRadius: 1,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: const TextStyle(
          color: TmColors.accent,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }
}
