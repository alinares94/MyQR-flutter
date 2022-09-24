
import 'package:flutter/material.dart';
import 'package:my_qr/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;

  ThemeProvider({
    required bool isDarkMode
  }) : currentTheme = AppTheme.getTheme(isDarkMode);

  setLightTheme() {
    currentTheme = AppTheme.getTheme(false);
    notifyListeners();
  }

  setDarkTheme() {
    currentTheme = AppTheme.getTheme(true);
    notifyListeners();
  }
}