import 'package:flutter/material.dart';

/// Taskmap dark-theme palette — "control-room" style.
abstract final class TmColors {
  static final Color glassFill = Colors.white.withValues(alpha: 0.06);
  static final Color glassFillStrong = Colors.white.withValues(alpha: 0.10);
  static final Color glassBorder = Colors.white.withValues(alpha: 0.10);

  static const Color textPrimary = Color(0xFFF2F5F8);
  static const Color textSecondary = Color(0xFF9BA8B7);
  static const Color textMuted = Color(0xFF63707E);

  static const Color bg = Color(0xFF0B0F14);
  static const Color surface = Color(0xFF141B24);
  static final Color hairline = Colors.white.withValues(alpha: 0.08);

  static const Color accent = Color(0xFF38BDF8);
  static const Color danger = Color(0xFFEF4444);

  static const Color statusPending = Color(0xFFFBBF24);
  static const Color statusInProgress = Color(0xFF38BDF8);
  static const Color statusDone = Color(0xFF22C55E);

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0B0F14), Color(0xFF0C1620), Color(0xFF0B0F14)],
    stops: [0.0, 0.55, 1.0],
  );
}
