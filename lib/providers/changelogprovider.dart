import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../const/consts.dart';

class ChangelogProvider with ChangeNotifier {
  ChangelogProvider() {
    fetchChangelog();
    //fatchData();
  }
  String? _changelogContent;
  String? get changelogContent => _changelogContent;
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  // Future<void> fatchData() async {
  //   try {
  //     log("6");
  //     _changelogContent = await changelog();
  //     log("4");
  //   } catch (e) {
  //     log("5");
  //     throw ExceptionHandlers.getExceptionString(e);
  //   }
  //   notifyListeners();
  // }

  // Future<String> changelog() async {
  //   try {
  //     _changelogContent = await ChangeLogApiService.changelog();
  //     log("3");
  //   } catch (e) {
  //     throw ExceptionHandlers.getExceptionString(e);
  //   }

  //   return _changelogContent;
  // }

  Future<void> refresh() async {
    _isFetching = true;
    await fetchChangelog();
    _isFetching = false;
    notifyListeners();
  }

  Future<void> fetchChangelog() async {
    _isFetching = true;
    final url = Consts.CHANGE_LOG_URL;
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        _changelogContent = response.body;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    _isFetching = false;
    notifyListeners();
  }
}
