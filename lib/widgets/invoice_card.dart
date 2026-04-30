import 'package:flutter/material.dart';
import '../core/theme/app_theme_tokens.dart';
import '../core/utils/currency.dart';
import '../core/utils/date.dart';
import 'status_badge.dart';

class InvoiceCard extends StatelessWidget {
  final String series;
  final int number;
  final String status;
  final String? clientName;
  final double total;
  final String? issuedAt;
  final VoidCallback? onTap;

  const InvoiceCard({
    super.key,
    required this.series,
    required this.number,
    required this.status,
    this.clientName,
    required this.total,
    required this.issuedAt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
        boxShadow: [
          BoxShadow(
            color: context.appShadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$series-${number.toString().padLeft(4, '0')}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: context.appText,
                      ),
                    ),
                    StatusBadge(status: status),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        clientName ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: context.appTextMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      formatCurrency(total),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: context.appText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatDate(issuedAt),
                    style: TextStyle(
                      fontSize: 11,
                      color: context.appTextSubtle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
