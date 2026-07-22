import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeStorageKey = 'app_theme_mode';

/// Instancia de SharedPreferences precargada en `main()` ANTES del primer
/// frame. Se inyecta vía override para poder leer el tema de forma síncrona
/// y evitar el parpadeo de tema al arrancar.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('override en main()'),
);

final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeMode>(ThemeController.new);

class ThemeController extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    // Lectura SÍNCRONA: el tema correcto ya está en el primer frame → sin flash.
    final prefs = ref.read(sharedPreferencesProvider);
    return _parse(prefs.getString(_themeStorageKey));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(
          _themeStorageKey,
          mode.name,
        );
  }

  Future<void> toggleDarkLight() async {
    await setThemeMode(
      state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  ThemeMode _parse(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
