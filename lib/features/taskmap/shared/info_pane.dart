import 'package:flutter/material.dart';

import 'glass_card.dart';
import 'tm_colors.dart';
import 'tm_spacing.dart';
import 'tm_type.dart';

/// Centered glass panel for empty / coming-soon / error states.
class InfoPane extends StatelessWidget {
  const InfoPane({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.accent = TmColors.accent,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color accent;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TmSpacing.xl),
        child: GlassCard(
          padding: const EdgeInsets.all(TmSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.14),
                  border: Border.all(color: accent.withValues(alpha: 0.40)),
                ),
                child: Icon(icon, color: accent, size: 26),
              ),
              const SizedBox(height: TmSpacing.lg),
              Text(title, style: TmType.h2, textAlign: TextAlign.center),
              if (subtitle != null) ...[
                const SizedBox(height: TmSpacing.sm),
                Text(
                  subtitle!,
                  style: TmType.body,
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: TmSpacing.lg),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
