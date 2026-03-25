import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        config.label,
        style: TextStyle(
          color: config.textColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.04 * 11,
        ),
      ),
    );
  }

  static _StatusConfig _getConfig(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
        return _StatusConfig('BORRADOR', AppColors.gray100, AppColors.gray600);
      case 'confirmed':
        return _StatusConfig('CONFIRMADA', AppColors.primaryBg, AppColors.primary);
      case 'paid':
        return _StatusConfig('PAGADA', AppColors.successBg, AppColors.success);
      case 'cancelled':
        return _StatusConfig('ANULADA', AppColors.dangerBg, AppColors.danger);
      default:
        return _StatusConfig(
            status.toUpperCase(), AppColors.gray100, AppColors.gray600);
    }
  }
}

class _StatusConfig {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  _StatusConfig(this.label, this.backgroundColor, this.textColor);
}
