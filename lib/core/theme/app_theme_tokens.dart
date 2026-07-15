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

  /// Text/icon color that reads on top of a filled [appPrimary] surface.
  Color get onPrimary => Colors.white;

  // ---- Semantic status tokens (adaptive) ----------------------------------
  // `*Strong` = foreground (text/icon). `*Soft` = tinted background patch.
  // In light mode we keep the existing pastel pairs; in dark mode we lighten
  // the foreground and use a translucent tint so patches don't glare.

  Color get statusSuccess => isDark ? const Color(0xFF4ADE80) : AppColors.success;
  Color get statusSuccessSoft =>
      isDark ? const Color(0x264ADE80) : AppColors.successBg;

  Color get statusWarning => isDark ? const Color(0xFFFBBF24) : AppColors.warning;
  Color get statusWarningSoft =>
      isDark ? const Color(0x26FBBF24) : AppColors.warningBg;

  Color get statusDanger => isDark ? const Color(0xFFF87171) : AppColors.danger;
  Color get statusDangerSoft =>
      isDark ? const Color(0x26F87171) : AppColors.dangerBg;

  Color get statusInfo => isDark ? AppColors.primaryLight : AppColors.primary;
  Color get statusInfoSoft =>
      isDark ? const Color(0x263B82F6) : AppColors.primaryBg;

  // "Emitida / final" — legally locked; deliberately distinct indigo.
  Color get statusFinal => isDark ? const Color(0xFF818CF8) : AppColors.indigo;
  Color get statusFinalSoft =>
      isDark ? const Color(0x26818CF8) : AppColors.indigoBg;

  Color get appShadow =>
      isDark ? Colors.black.withValues(alpha: 0.24) : Colors.black.withValues(alpha: 0.04);
}
