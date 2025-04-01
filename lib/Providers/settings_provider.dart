import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  static const String _themeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';
  static const String _cacheKey = 'cache_enabled';
  ThemeMode _themeMode;

  SettingsProvider(this._prefs) : _themeMode = _loadThemeMode(_prefs);

  ThemeMode get themeMode => _themeMode;

  static ThemeMode _loadThemeMode(SharedPreferences prefs) {
    final themeName = prefs.getString(_themeKey);
    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  bool get notificationsEnabled => _prefs.getBool(_notificationsKey) ?? true;
  bool get cacheEnabled => _prefs.getBool(_cacheKey) ?? true;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs.setString(_themeKey, mode.toString());
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_notificationsKey, enabled);
    notifyListeners();
  }

  Future<void> setCacheEnabled(bool enabled) async {
    await _prefs.setBool(_cacheKey, enabled);
    notifyListeners();
  }

  Future<void> resetSettings() async {
    await _prefs.clear();
    _themeMode = ThemeMode.system;
    notifyListeners();
  }
} 