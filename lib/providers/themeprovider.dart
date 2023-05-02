import 'dart:developer';

import 'package:flutter/material.dart';

// import '../services/theme_prefrence.dart';

class ThemeProvider with ChangeNotifier {
  // ThemePrefrences themePrefrences = ThemePrefrences();
  ThemeProvider(BuildContext context) {
    getSystemTheme(context);
  }
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  set setTheme(bool value) {
    _isDarkTheme = value;
    // themePrefrences.setTheme(value);
    notifyListeners();
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  getSystemTheme(BuildContext context) {
    _isDarkTheme =
        WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    notifyListeners();
  }
}
