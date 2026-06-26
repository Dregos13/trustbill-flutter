import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'glass_card.dart';
import 'tm_spacing.dart';

/// Subtle pulsing placeholder block. Honors the platform "reduce motion" setting.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    super.key,
    this.width = 80,
    this.height = 14,
    this.radius = 6,
  });

  final double width;
  final double height;
  final double radius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      if (_controller.isAnimating) _controller.stop();
      return _box(0.07);
    }
    if (!_controller.isAnimating) _controller.repeat(reverse: true);
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) => _box(lerpDouble(0.04, 0.10, _controller.value)!),
    );
  }

  Widget _box(double alpha) => Container(
    width: widget.width,
    height: widget.height,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: alpha),
      borderRadius: BorderRadius.circular(widget.radius),
    ),
  );
}

/// Skeleton matching the dashboard StatCard.
class SkeletonStatCard extends StatelessWidget {
  const SkeletonStatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      padding: EdgeInsets.all(TmSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(width: 16, height: 16, radius: 4),
          SizedBox(height: TmSpacing.sm),
          SkeletonBox(width: 36, height: 22),
          SizedBox(height: 6),
          SkeletonBox(width: 60, height: 10),
        ],
      ),
    );
  }
}

/// Skeleton matching a TaskListItem.
class SkeletonTaskCard extends StatelessWidget {
  const SkeletonTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SkeletonBox(width: 88, height: 20, radius: 999),
              Spacer(),
              SkeletonBox(width: 48, height: 12),
            ],
          ),
          SizedBox(height: TmSpacing.md),
          SkeletonBox(width: 200, height: 16),
          SizedBox(height: TmSpacing.sm),
          SkeletonBox(width: 130, height: 12),
        ],
      ),
    );
  }
}
