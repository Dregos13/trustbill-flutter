import 'package:flutter/material.dart';
import 'tm_colors.dart';

/// Typography for the taskmap zone. Styles resolve their color from the
/// active palette ([context.tm]) so they adapt to light/dark. Call with the
/// build context: `Text('x', style: TmType.body(context))`.
abstract final class TmType {
  static const List<FontFeature> _tabular = [FontFeature.tabularFigures()];

  static TextStyle display(BuildContext c) => TextStyle(
    fontSize: 26,
    height: 1.15,
    fontWeight: FontWeight.w800,
    color: c.tm.textPrimary,
  );

  static TextStyle h2(BuildContext c) => TextStyle(
    fontSize: 18,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: c.tm.textPrimary,
  );

  static TextStyle title(BuildContext c) => TextStyle(
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w600,
    color: c.tm.textPrimary,
  );

  static TextStyle body(BuildContext c) => TextStyle(
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: c.tm.textSecondary,
  );

  static TextStyle label(BuildContext c) => TextStyle(
    fontSize: 12.5,
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: c.tm.textSecondary,
  );

  static TextStyle overline(BuildContext c) => TextStyle(
    fontSize: 11,
    height: 1.1,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: c.tm.textMuted,
  );

  static TextStyle money(BuildContext c) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: c.tm.textPrimary,
    fontFeatures: _tabular,
  );

  static TextStyle moneyLg(BuildContext c) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: c.tm.textPrimary,
    fontFeatures: _tabular,
  );
}
