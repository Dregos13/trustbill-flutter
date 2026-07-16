import 'package:flutter/material.dart';

import '../../data/models/field_task.dart';
import '../../shared/format.dart';
import '../../shared/glass_card.dart';
import '../../shared/money_text.dart';
import '../../shared/status_chip.dart';
import '../../shared/tm_colors.dart';
import '../../shared/tm_spacing.dart';
import '../../shared/tm_type.dart';

/// Reusable task card — used in the map's client sheet and the agenda list.
class TaskListItem extends StatelessWidget {
  const TaskListItem({
    super.key,
    required this.task,
    this.onTap,
    this.trailing,
    this.showClient = true,
  });

  final FieldTask task;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showClient;

  @override
  Widget build(BuildContext context) {
    final bill = task.bill;
    return GlassCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusChip(task.status, dense: true),
              const Spacer(),
              if (task.scheduledAt != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.event_rounded,
                      size: 13,
                      color: context.tm.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      formatDay(task.scheduledAt!),
                      style: TmType.label(context).copyWith(color: context.tm.textMuted),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: TmSpacing.sm),
          Text(
            task.title,
            style: TmType.title(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (showClient) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(
                  Icons.place_rounded,
                  size: 14,
                  color: context.tm.textSecondary,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    task.client.name,
                    style: TmType.body(context),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (bill != null || trailing != null) ...[
            const SizedBox(height: TmSpacing.md),
            Row(
              children: [
                if (bill != null) ...[
                  Icon(
                    Icons.receipt_long_rounded,
                    size: 14,
                    color: context.tm.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      bill.number,
                      style: TmType.label(context).copyWith(color: context.tm.textMuted),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: TmSpacing.sm),
                  MoneyText(bill.total, style: TmType.title(context)),
                ],
                const Spacer(),
                ?trailing,
              ],
            ),
          ],
        ],
      ),
    );
  }
}
