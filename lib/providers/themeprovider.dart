import 'package:flutter/material.dart';

// import '../services/theme_prefrence.dart';

class ThemeProvider with ChangeNotifier {
  // ThemePrefrences themePrefrences = ThemePrefrences();
  // bool _isDarkTheme = false;
  // bool get getDarkTheme => _isDarkTheme;

  // set setTheme(bool value) {
  //   _isDarkTheme = value;
  //   // themePrefrences.setTheme(value);
  //   notifyListeners();
  // }

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
