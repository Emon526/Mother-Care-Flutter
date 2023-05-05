import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider() {
    fatchLanguageData();
  }
  bool _isBoardingCompleate = false;
  bool get isBoardingCompleate => _isBoardingCompleate;

  set isBoardingCompleate(bool value) {
    _isBoardingCompleate = value;
    boardingCompleated();
    notifyListeners();
  }

  String _languageCode = 'en';
  String get languageCode => _languageCode;

  set languageCode(String languageCode) {
    _languageCode = languageCode;
    log('Language chnaged translate words');
    notifyListeners();
  }

  boardingCompleated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isBoardingCompleate', isBoardingCompleate);
    savelanguage(languageCode: _languageCode);
    notifyListeners();
  }

  void savelanguage({required String languageCode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }

  getBoarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isBoardingCompleate =
        prefs.getBool('isBoardingCompleate') ?? _isBoardingCompleate;
    log(_isBoardingCompleate.toString());
  }

  getLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('languageCode') ?? _languageCode;
    log(_languageCode.toString());
  }

  void fatchLanguageData() async {
    await getBoarding();
    await getLanguage();

    notifyListeners();
  }
}
