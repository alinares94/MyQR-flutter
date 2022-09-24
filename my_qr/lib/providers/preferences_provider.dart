

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  static late SharedPreferences _preferences;
  static bool _isDarkTheme = false;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _preferences.getBool('isDarkMode') ?? _isDarkTheme;
  }

  static set isDarkMode(bool value) {
    _isDarkTheme = value;
    _preferences.setBool('isDarkMode', value);
  }
}