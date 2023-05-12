import 'package:flutter/material.dart';

class SelfCheckProvider extends ChangeNotifier {
  int _current = 0;
  int get current => _current;
  int _totalSteps = 7;
  int get totalSteps => _totalSteps;
  set totalSteps(int index) {
    _totalSteps = index;
    notifyListeners();
  }

  set current(int index) {
    _current = index;
    notifyListeners();
  }
}
