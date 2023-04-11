import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/doctormodel.dart';
import '../services/doctorapiservice.dart';
import '../utils/exception_hander.dart';

class DoctorProvider extends ChangeNotifier {
  List<DoctorModel> _doctorList = [];
  List<DoctorModel> get doctorlist => _doctorList;
  List<DoctorModel> _filterdoctorList = [];
  List<DoctorModel> get filterdoctorList => _filterdoctorList;
  List<String> _filterChoice = [];
  List<String> get filterChoice => _filterChoice;
  set filterChoice(List<String> filters) {
    _filterChoice = filters;
    _filterdoctorList = getFilteredDoctor(searchQuery: filters);
    notifyListeners();
  }

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
      var firstdata = a.rating;
      var lastdata = b.rating;
      return lastdata.compareTo(firstdata);
    });
  }

  refresh() async {
    _doctorList = await doctorsList();
    notifyListeners();
  }

  List<DoctorModel> getFilteredDoctor({required List<String> searchQuery}) {
    return _doctorList.where((doctor) {
      final doctorLocation = doctor.location.toLowerCase();
      return searchQuery
          .any((query) => doctorLocation.contains(query.toLowerCase()));
    }).toList();
  }

  List<String> getAllDoctorLocations() {
    Set<String> uniqueLocations = <String>{};
    for (DoctorModel doctor in _doctorList) {
      uniqueLocations.add(doctor.location);
    }
    List<String> formattedLocations = uniqueLocations.toList()..sort();
    return formattedLocations;
  }

  Future<Uint8List?> getDoctorImage(String imagebyte) async {
    // debugPrint(imagebyte);

    return base64Decode(imagebyte);
  }
}
