import 'package:flutter/material.dart';
import 'tm_colors.dart';

/// Typography for taskmap screens (dark / control-room theme).
abstract final class TmType {
  static const List<FontFeature> _tabular = [FontFeature.tabularFigures()];

  static const TextStyle display = TextStyle(
    fontSize: 26,
    height: 1.15,
    fontWeight: FontWeight.w800,
    color: TmColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 18,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: TmColors.textPrimary,
  );

  static const TextStyle title = TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: TmColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: TmColors.textSecondary,
  );

  static const TextStyle label = TextStyle(
    fontSize: 12.5,
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: TmColors.textSecondary,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 11,
    height: 1.1,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: TmColors.textMuted,
  );

  static const TextStyle money = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: TmColors.textPrimary,
    fontFeatures: _tabular,
  );

  static const TextStyle moneyLg = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: TmColors.textPrimary,
    fontFeatures: _tabular,
  );
}
