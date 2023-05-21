import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctormodel.dart';
import '../services/doctorapiservice.dart';
import '../utils/exception_hander.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> _doctorList = [];
  List<DoctorModel> get doctorlist => _doctorList;
  // List<DoctorModel> _filterdoctorList = [];
  // List<DoctorModel> get filterdoctorList => _filterdoctorList;
  List<String> _filterChoice = [];
  List<String> get filterChoice => _filterChoice;
  set filterChoice(List<String> filters) {
    _filterChoice = filters;
    // _filterdoctorList = getFilteredDoctor(searchQuery: filters);
    notifyListeners();
  }

  DoctorProvider() {
    fatchData();
  }

  Future<void> fatchData() async {
    try {
      _doctorList = await doctorsList();
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }
    notifyListeners();
  }

  Future<List<DoctorModel>> doctorsList() async {
    try {
      _doctorList = await DoctorsApiService.doctorslist();
      sortDoctors();
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }

    return _doctorList;
  }

  void sortDoctors() {
    _doctorList.sort((a, b) {
      var firstdata = a.rating;
      var lastdata = b.rating;
      return lastdata.compareTo(firstdata);
    });
  }

  Future<void> refresh() async {
    _doctorList = await doctorsList();
    notifyListeners();
  }

  // List<DoctorModel> getFilteredDoctor({required List<String> searchQuery}) {
  //   return _doctorList.where((doctor) {
  //     final doctorLocation = doctor.location.toLowerCase();
  //     return searchQuery
  //         .any((query) => doctorLocation.contains(query.toLowerCase()));
  //   }).toList();
  // }
  // List<DoctorModel> getFilteredDoctor({required List<String> searchQuery}) {
  //   return _doctorList.where((doctor) {
  //     final doctorLocation = doctor.location['bn'].toString().toLowerCase();
  //     return searchQuery
  //         .any((query) => doctorLocation.contains(query.toLowerCase()));
  //   }).toList();
  // }

  Future<Uint8List?> getDoctorImage(String imagebyte) async {
    // debugPrint(imagebyte);

    return base64Decode(imagebyte);
  }
}
