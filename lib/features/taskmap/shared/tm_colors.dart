import 'package:flutter/material.dart';

/// Adaptive "control-room" palette for the taskmap/agenda/calendar zone.
///
/// Keeps the original dark identity and adds a matching light variant.
/// Resolve per-context with `context.tm` — never reference a palette
/// instance directly so the widget follows the active [ThemeMode].
class TmPalette {
  const TmPalette({
    required this.glassFill,
    required this.glassFillStrong,
    required this.glassBorder,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.bg,
    required this.surface,
    required this.hairline,
    required this.accent,
    required this.danger,
    required this.statusPending,
    required this.statusInProgress,
    required this.statusDone,
    required this.backgroundGradient,
    required this.skeletonBase,
    required this.mapTilesLight,
  });

  final Color glassFill;
  final Color glassFillStrong;
  final Color glassBorder;

  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  final Color bg;
  final Color surface;
  final Color hairline;

  final Color accent;
  final Color danger;

  final Color statusPending;
  final Color statusInProgress;
  final Color statusDone;

  final LinearGradient backgroundGradient;

  /// Base tint for the skeleton shimmer (alpha applied at use site).
  final Color skeletonBase;

  /// True → use the light CARTO basemap tiles; false → dark tiles.
  final bool mapTilesLight;

  // ── Dark (original identity) ────────────────────────────────────────────
  static const dark = TmPalette(
    glassFill: Color(0x0FFFFFFF), // white 6%
    glassFillStrong: Color(0x1AFFFFFF), // white 10%
    glassBorder: Color(0x1AFFFFFF), // white 10%
    textPrimary: Color(0xFFF2F5F8),
    textSecondary: Color(0xFF9BA8B7),
    textMuted: Color(0xFF63707E),
    bg: Color(0xFF0B0F14),
    surface: Color(0xFF141B24),
    hairline: Color(0x14FFFFFF), // white 8%
    accent: Color(0xFF38BDF8),
    danger: Color(0xFFEF4444),
    statusPending: Color(0xFFFBBF24),
    statusInProgress: Color(0xFF38BDF8),
    statusDone: Color(0xFF22C55E),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0B0F14), Color(0xFF0C1620), Color(0xFF0B0F14)],
      stops: [0.0, 0.55, 1.0],
    ),
    skeletonBase: Color(0xFFFFFFFF),
    mapTilesLight: false,
  );

  // ── Light (matching control-room, tuned for contrast) ────────────────────
  static const light = TmPalette(
    glassFill: Color(0x08000000), // black 3%
    glassFillStrong: Color(0x0D000000), // black 5%
    glassBorder: Color(0x14000000), // black 8%
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF94A3B8),
    bg: Color(0xFFF1F5F9),
    surface: Color(0xFFFFFFFF),
    hairline: Color(0x0D000000), // black 5%
    accent: Color(0xFF2563EB),
    danger: Color(0xFFDC2626),
    statusPending: Color(0xFFD97706),
    statusInProgress: Color(0xFF2563EB),
    statusDone: Color(0xFF16A34A),
    backgroundGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFFF8FAFC), Color(0xFFEEF2F7), Color(0xFFF8FAFC)],
      stops: [0.0, 0.55, 1.0],
    ),
    skeletonBase: Color(0xFF0F172A),
    mapTilesLight: true,
  );
}

/// Resolve the taskmap palette for the active theme brightness.
extension TmThemeX on BuildContext {
  TmPalette get tm => Theme.of(this).brightness == Brightness.dark
      ? TmPalette.dark
      : TmPalette.light;
}
