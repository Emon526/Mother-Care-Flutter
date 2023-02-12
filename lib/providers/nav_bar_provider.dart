import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  PersistentTabController get controller => _controller;

  set setControllerIndex(int index) {
    _controller.index = index;
    notifyListeners();
  }
}
