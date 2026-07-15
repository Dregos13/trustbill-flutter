import 'package:flutter/material.dart';
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
        return _StatusConfig('CONFIRMADA', context.statusInfoSoft, context.statusInfo);
      case 'final':
        return _StatusConfig('EMITIDA', context.statusFinalSoft, context.statusFinal);
      case 'paid':
        return _StatusConfig('PAGADA', context.statusSuccessSoft, context.statusSuccess);
      case 'canceled':
      case 'cancelled':
        return _StatusConfig('ANULADA', context.statusDangerSoft, context.statusDanger);

      // ---- Budget quoteStatus ----
      case 'pending':
        return _StatusConfig('PENDIENTE', context.statusWarningSoft, context.statusWarning);
      case 'accepted':
        return _StatusConfig('ACEPTADO', context.statusSuccessSoft, context.statusSuccess);
      case 'rejected':
        return _StatusConfig('RECHAZADO', context.statusDangerSoft, context.statusDanger);

      // ---- Sale status ----
      case 'open':
        return _StatusConfig('ABIERTA', context.statusInfoSoft, context.statusInfo);
      case 'partially_invoiced':
        return _StatusConfig('PARCIAL', context.statusWarningSoft, context.statusWarning);
      case 'closed':
        return _StatusConfig('CERRADA', context.statusSuccessSoft, context.statusSuccess);
      case 'lost':
        return _StatusConfig('PERDIDA', context.statusDangerSoft, context.statusDanger);

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
