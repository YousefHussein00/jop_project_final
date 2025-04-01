import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  static const String _localeKey = 'locale';
  Locale? _locale;
  final SharedPreferences _prefs;

  LocaleProvider(this._prefs) {
    // قراءة اللغة المحفوظة
    final savedLocale = _prefs.getString(_localeKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }
    log(savedLocale.toString(), name: 'savedLocale');
  }

  Locale? get locale => _locale;

  Future<void> setLocale(Locale locale) async {
    if (!['en', 'ar'].contains(locale.languageCode)) return;

    _locale = locale;
    // حفظ اللغة المحددة
    await _prefs.setString(_localeKey, locale.languageCode);
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    _prefs.remove(_localeKey);
    notifyListeners();
  }
}
