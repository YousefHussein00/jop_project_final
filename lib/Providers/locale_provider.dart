import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  static const String _localeKey = 'locale';
  static const String _seenOnboardingKey = 'seenOnboarding';
  Locale? _locale;
  bool _seenOnboarding = false;
  bool _isLodingSeenOnboarding = false;
  final SharedPreferences _prefs;
  bool get seenOnboarding => _seenOnboarding;
  bool get isLodingSeenOnboarding => _isLodingSeenOnboarding;

  void setSeenOnboarding(bool value) async {
    _setIsLodingSeenOnboarding(true);
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    await _prefs.setBool(_seenOnboardingKey, value).then(
      (value) {
        if (value == true) {
          _cleanIsLodingSeenOnboarding();
        }
        return value;
      },
    );
    _seenOnboarding = (_prefs.getBool(_seenOnboardingKey)) ?? false;
    notifyListeners();
  }

  void _setIsLodingSeenOnboarding(bool value) async {
    _isLodingSeenOnboarding = value;
    notifyListeners();
  }

  void _cleanIsLodingSeenOnboarding() async {
    _isLodingSeenOnboarding = false;
    notifyListeners();
  }

  void init() {
    _seenOnboarding = (_prefs.getBool(_seenOnboardingKey)) ?? false;
    final savedLocale = _prefs.getString(_localeKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }
    log(savedLocale.toString(), name: 'savedLocale');
    // _seenOnboarding = (_prefs.getBool(_seenOnboardingKey)) ?? false;
    log(_seenOnboarding.toString(), name: 'seenOnboarding');
  }

  LocaleProvider(this._prefs) {
    // قراءة اللغة المحفوظة
    _seenOnboarding = (_prefs.getBool(_seenOnboardingKey)) ?? false;
    final savedLocale = _prefs.getString(_localeKey);
    if (savedLocale != null) {
      _locale = Locale(savedLocale);
    }
    log(savedLocale.toString(), name: 'savedLocale');
    // _seenOnboarding = (_prefs.getBool(_seenOnboardingKey)) ?? false;
    log(_seenOnboarding.toString(), name: 'seenOnboarding');
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
