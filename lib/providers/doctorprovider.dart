import 'package:flutter/material.dart';

import '../models/doctormodel.dart';
import '../services/doctorapiservice.dart';

class DoctorProvider extends ChangeNotifier {
  bool isLoading = true;

  List<DoctorModel> _doctorList = [];
  List<DoctorModel> get doctorlist => _doctorList;
  DoctorProvider() {
    fatchDoctors();
  }
  void fatchDoctors() async {
    _doctorList = await DoctorsApiService.doctorslist();
    sortDoctors();
    isLoading = false;
    notifyListeners();
  }

  void sortDoctors() {
    _doctorList.sort((a, b) {
      var firstdata = a.review;
      var lastdata = b.review;
      return lastdata.compareTo(firstdata);
    });
  }

  // List<DoctorModel> getFilteredDoctor({required String searchQuery}) {
  //   return _doctorList
  //       .where((element) =>
  //           element.location.toLowerCase().contains(searchQuery.toLowerCase()))
  //       .toList();
  // }
}
