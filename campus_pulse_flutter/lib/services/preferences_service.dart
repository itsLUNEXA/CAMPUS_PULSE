import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier {
  static const String _keyThemeMode = 'campus_pulse_theme_mode';
  static const String _keyCookieConsent = 'campus_pulse_cookie_consent';
  static const String _keyAnalyticsConsent = 'campus_pulse_analytics_consent';

  ThemeMode _themeMode = ThemeMode.light;
  bool? _cookieConsent; // null = pending, true = accepted, false = rejected
  bool _analyticsConsent = false;

  ThemeMode get themeMode => _themeMode;
  bool? get cookieConsent => _cookieConsent;
  bool get analyticsConsent => _analyticsConsent;
  bool get hasConsentedToCookies => _cookieConsent != null;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeStr = prefs.getString(_keyThemeMode);
      if (themeStr != null) {
        if (themeStr == 'light') _themeMode = ThemeMode.light;
        if (themeStr == 'dark') _themeMode = ThemeMode.dark;
        if (themeStr == 'system') _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.light;
      }

      if (prefs.containsKey(_keyCookieConsent)) {
        _cookieConsent = prefs.getBool(_keyCookieConsent);
      }
      _analyticsConsent = prefs.getBool(_keyAnalyticsConsent) ?? false;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyThemeMode, mode.name);
    } catch (_) {}
  }

  Future<void> setCookieConsent({
    required bool accepted,
    bool allowAnalytics = false,
  }) async {
    _cookieConsent = accepted;
    _analyticsConsent = accepted && allowAnalytics;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyCookieConsent, accepted);
      await prefs.setBool(_keyAnalyticsConsent, _analyticsConsent);
    } catch (_) {}
  }
}
