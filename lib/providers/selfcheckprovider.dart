import 'package:flutter/material.dart';

class SelfCheckProvider extends ChangeNotifier {
  int _currentStep = 0;
  int get currentStep => _currentStep;
  int _totalSteps = 7;
  int get totalSteps => _totalSteps;
  set totalSteps(int index) {
    _totalSteps = index;
    notifyListeners();
  }

  set currentStep(int index) {
    _currentStep = index;
    notifyListeners();
  }

  int _currentSlider = 0;
  int get currentSlider => _currentSlider;
  set currentSlider(int index) {
    _currentSlider = index;
    notifyListeners();
  }
}
