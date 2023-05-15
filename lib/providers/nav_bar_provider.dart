// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBarProvider with ChangeNotifier {
  NavBarProvider() {
    getAppVersion();
  }
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  String _appVersion = '';
  String get appVersion => _appVersion;

  Future<void> getAppVersion() async {
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

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  PersistentTabController get controller => _controller;

  set setControllerIndex(int index) {
    _controller.index = index;
    notifyListeners();
  }
}
