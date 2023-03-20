import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctormodel.dart';
import '../services/doctorapiservice.dart';
import '../utils/exception_hander.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> _doctorList = [];
  List<DoctorModel> get doctorlist => _doctorList;

  Future<List<DoctorModel>> doctorsList() async {
    try {
      _doctorList = [];
      var response = await DoctorsApiService.doctorslist();
      var decodeddoctorsList = jsonDecode(response.body)['doctors'];
      for (var doctor in decodeddoctorsList) {
        DoctorModel newDoctor = DoctorModel.fromMap(doctor);
        _doctorList.add(newDoctor);
      }

      sortDoctors();
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }

    return _doctorList;
  }

  void sortDoctors() {
    _doctorList.sort((a, b) {
      var firstdata = a.review;
      var lastdata = b.review;
      return lastdata.compareTo(firstdata);
    });
  }

  refresh() async {
    _doctorList = await doctorsList();
    notifyListeners();
  }

  // List<DoctorModel> getFilteredDoctor({required String searchQuery}) {
  //   return _doctorList
  //       .where((element) =>
  //           element.location.toLowerCase().contains(searchQuery.toLowerCase()))
  //       .toList();
  // }

  Future<Uint8List?> getDoctorImage(String imagebyte) async {
    // debugPrint(imagebyte);

    return base64Decode(imagebyte);
  }
}
