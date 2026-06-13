import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme_tokens.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(context, status);
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

  static _StatusConfig _getConfig(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      // ---- Invoice status ----
      case 'draft':
        return _StatusConfig('BORRADOR', context.appSurfaceRaised, context.appTextMuted);
      case 'confirmed':
        return _StatusConfig('CONFIRMADA', AppColors.primaryBg, AppColors.primary);
      case 'final':
        return _StatusConfig('EMITIDA', AppColors.indigoBg, AppColors.indigo);
      case 'paid':
        return _StatusConfig('PAGADA', AppColors.successBg, AppColors.success);
      case 'canceled':
      case 'cancelled':
        return _StatusConfig('ANULADA', AppColors.dangerBg, AppColors.danger);

      // ---- Budget quoteStatus ----
      case 'pending':
        return _StatusConfig('PENDIENTE', AppColors.warningBg, AppColors.warning);
      case 'accepted':
        return _StatusConfig('ACEPTADO', AppColors.successBg, AppColors.success);
      case 'rejected':
        return _StatusConfig('RECHAZADO', AppColors.dangerBg, AppColors.danger);

      // ---- Sale status ----
      case 'open':
        return _StatusConfig('ABIERTA', AppColors.primaryBg, AppColors.primary);
      case 'partially_invoiced':
        return _StatusConfig('PARCIAL', AppColors.warningBg, AppColors.warning);
      case 'closed':
        return _StatusConfig('CERRADA', AppColors.successBg, AppColors.success);
      case 'lost':
        return _StatusConfig('PERDIDA', AppColors.dangerBg, AppColors.danger);

      default:
        return _StatusConfig(
            status.toUpperCase(), context.appSurfaceRaised, context.appTextMuted);
    }
  }
}

class _StatusConfig {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  _StatusConfig(this.label, this.backgroundColor, this.textColor);
}
