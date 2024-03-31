import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider(BuildContext context) {
    getSystemTheme(context);
    getTheme();
  }
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    saveTheme(themeMode: themeMode.name);
    notifyListeners();
  }

  void removesplash() async {
    await Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
      debugPrint('remove splash');
    });
  }

  saveTheme({required String themeMode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', themeMode);
  }

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = prefs.getString('themeMode') ?? 'system';
    _themeMode = ThemeMode.values.firstWhere(
        (element) => element.toString() == 'ThemeMode.$theme',
        orElse: () => ThemeMode.system);
    // notifyListeners();
    log(_themeMode.toString(), name: 'getTheme _themeMode');
  }

  getSystemTheme(BuildContext context) {
    _isDarkTheme =
        // WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
        WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    // notifyListeners();
    log(_isDarkTheme.toString(), name: 'getSystemTheme _isDarkTheme');
  }
}
