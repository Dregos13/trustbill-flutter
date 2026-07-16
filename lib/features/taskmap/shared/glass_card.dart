import 'dart:ui';

import 'package:flutter/material.dart';

import 'tm_colors.dart';
import 'tm_spacing.dart';

/// Frosted-glass surface: backdrop blur + translucent fill + hairline border.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(TmSpacing.lg),
    this.onTap,
    this.borderRadius = TmRadii.brLg,
    this.strong = false,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final bool strong;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final card = ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: strong ? context.tm.glassFillStrong : context.tm.glassFill,
            borderRadius: borderRadius,
            border: Border.all(color: borderColor ?? context.tm.glassBorder),
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: borderRadius, onTap: onTap, child: card),
    );
  }
}
