import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBarProvider with ChangeNotifier {
  NavBarProvider() {
    appVersionInfo();
  }
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String _appVersionInfo = '';
  String get appVersion => _appVersionInfo;

  Future<void> appVersionInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersionInfo = 'Version : ${packageInfo.version}';
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  PersistentTabController get controller => _controller;

  set setControllerIndex(int index) {
    _controller.index = index;
    notifyListeners();
  }
}
