import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _themeStorageKey = 'app_theme_mode';

final themeControllerProvider =
    NotifierProvider<ThemeController, ThemeMode>(ThemeController.new);

class ThemeController extends Notifier<ThemeMode> {
  late final FlutterSecureStorage _storage;

  @override
  ThemeMode build() {
    _storage = const FlutterSecureStorage();
    return ThemeMode.system;
  }

  Future<void> initialize() async {
    final value = await _storage.read(key: _themeStorageKey);
    state = _parse(value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _storage.write(key: _themeStorageKey, value: mode.name);
  }

  Future<void> toggleDarkLight() async {
    await setThemeMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  ThemeMode _parse(String? value) {
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
