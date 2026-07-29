import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Bundled variable font — same brand identity on Android & iOS (no runtime fetch).
const _fontFamily = 'Inter';

const darkBackground = Color(0xFF080D18);
const darkHeader = Color(0xFF0B1120);
const darkSurface = Color(0xFF0F172A);
const darkBorder = Color(0xFF1F2937);
const darkInputBorder = Color(0xFF334155);
const darkText = Color(0xFFF8FAFC);

ThemeData buildAppTheme() {
  final textTheme = ThemeData.light().textTheme.apply(fontFamily: _fontFamily);

  return ThemeData(
    useMaterial3: true,
    fontFamily: _fontFamily,
    colorSchemeSeed: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    // ZoomPageTransitionsBuilder (el default de Android) rasteriza ambas rutas
    // a una textura (snapshot) y anima esa textura — caro en GPUs modestas, y
    // ademas la snapshot queda "congelada" con el estado que tuviera la
    // pantalla en ese instante: como nuestras pantallas de detalle pasan de
    // loading a datos casi inmediatamente tras el push, se notaba como un
    // salto/lag en cada navegacion (clientes, facturas, ventas, presupuestos).
    // FadeForwardsPageTransitionsBuilder no usa snapshot (fade+slide en vivo),
    // mucho mas barato y sin ese problema de contenido desactualizado.
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            FadeForwardsPageTransitionsBuilder(backgroundColor: AppColors.background),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.gray100),
      ),
      margin: const EdgeInsets.only(bottom: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.gray300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.gray300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}

ThemeData buildDarkAppTheme() {
  final textTheme = ThemeData.dark().textTheme.apply(fontFamily: _fontFamily);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      brightness: Brightness.dark,
      surface: darkSurface,
    ),
    scaffoldBackgroundColor: darkBackground,
    // Ver comentario en buildAppTheme(): FadeForwardsPageTransitionsBuilder en
    // vez de Zoom (sin snapshot, mas barato y sin el salto de contenido
    // desactualizado en pantallas que pasan de loading a datos al instante).
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android:
            FadeForwardsPageTransitionsBuilder(backgroundColor: darkBackground),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    textTheme: textTheme.apply(
      bodyColor: darkText,
      displayColor: darkText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkHeader,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: darkBorder),
      ),
      margin: const EdgeInsets.only(bottom: 12),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: darkInputBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: darkInputBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: darkHeader,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}
