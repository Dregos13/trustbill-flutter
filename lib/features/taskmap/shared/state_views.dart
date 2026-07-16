import 'package:flutter/material.dart';

import '../../../core/utils/error_messages.dart';
import 'info_pane.dart';
import 'tm_colors.dart';
import 'tm_spacing.dart';
import 'tm_type.dart';

/// Centered spinner with optional caption.
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: context.tm.accent,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: TmSpacing.md),
            Text(message!, style: TmType.label(context)),
          ],
        ],
      ),
    );
  }
}

/// Error state with a Retry action, message via [friendlyError].
class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.error, this.onRetry});

  final Object error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return InfoPane(
      icon: Icons.cloud_off_rounded,
      accent: context.tm.danger,
      title: 'Algo ha fallado',
      subtitle: friendlyError(error),
      action: onRetry == null
          ? null
          : FilledButton.tonal(
              onPressed: onRetry,
              child: const Text('Reintentar'),
            ),
    );
  }
}

/// Empty state.
class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return InfoPane(icon: icon, title: title, subtitle: subtitle);
  }
}
