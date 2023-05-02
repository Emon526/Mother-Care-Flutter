import 'dart:developer';

import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _languageCode = 'en';
  String get languageCode => _languageCode;

  set languageCode(String languageCode) {
    _languageCode = languageCode;
    notifyListeners();
  }

  savelanguage(String languageCode) async {
    _languageCode = languageCode;
    log(_languageCode);
    notifyListeners();
  }
}
