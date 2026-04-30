import 'package:flutter/material.dart';
import 'app_colors.dart';

extension AppThemeTokens on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get appBackground => Theme.of(this).scaffoldBackgroundColor;
  Color get appSurface => Theme.of(this).colorScheme.surface;
  Color get appSurfaceRaised =>
      isDark ? const Color(0xFF111C2F) : Colors.white;
  Color get appBorder => isDark ? const Color(0xFF1F2937) : AppColors.gray100;

  Color get appText => Theme.of(this).colorScheme.onSurface;
  Color get appTextMuted => isDark ? AppColors.gray400 : AppColors.gray500;
  Color get appTextSubtle => isDark ? AppColors.gray500 : AppColors.gray400;

  Color get appPrimary => isDark ? AppColors.primaryLight : AppColors.primary;
  Color get appPrimarySoft =>
      isDark ? const Color(0x263B82F6) : AppColors.primaryBg;

  Color get appShadow =>
      isDark ? Colors.black.withValues(alpha: 0.24) : Colors.black.withValues(alpha: 0.04);
}
