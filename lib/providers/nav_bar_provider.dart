import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

class NavBarProvider with ChangeNotifier {
  NavBarProvider() {
    initilizeNavBar();
    getAppVersion();
  }
  late PageController _pageController;
  PageController get pageController => _pageController;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    changePage(selectedIndex: _selectedIndex);
    notifyListeners();
  }

  String _appVersion = '';
  String get appVersion => _appVersion;

  void getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _appVersion = packageInfo.version;
    notifyListeners();
  }

  String appVersionInfo({required String locale}) {
    var parts = _appVersion.split('.');
    var translatedParts = parts
        .map((part) => NumberFormat('###', locale).format(int.parse(part)));
    return translatedParts.join('.');
  }

  void initilizeNavBar() {
    _pageController = PageController(initialPage: selectedIndex);
  }

  void changePage({required int selectedIndex}) {
    _pageController.animateToPage(
      selectedIndex,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutQuad,
    );
  }
  // final PersistentTabController _controller =
  //     PersistentTabController(initialIndex: 0);

  // PersistentTabController get controller => _controller;

  // set setControllerIndex(int index) {
  //   _controller.index = index;
  //   log(index.toString(), name: 'Controller index');
  //   notifyListeners();
  // }
}
