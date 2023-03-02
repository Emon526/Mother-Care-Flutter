import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mothercare/models/doctormodel.dart';

import '../const/consts.dart';

class DoctorsApiService {
  static const String _baseUrl = "${Consts.BASE_URL}/doctors";

  // static Future<void> addNote({required Note note}) async {
  //   Uri requestUri = Uri.parse("$_baseUrl/add");
  //   var response = await http.post(
  //     requestUri,
  //     body: note.toMap(),
  //   );
  //   var decoded = jsonDecode(response.body);
  //   log(decoded.toString());
  // }

  // static Future<void> deleteNote({required Note note}) async {
  //   Uri requestUri = Uri.parse("$_baseUrl/delete");
  //   var response = await http.post(
  //     requestUri,
  //     body: note.toMap(),
  //   );
  //   var decoded = jsonDecode(response.body);
  //   log(decoded.toString());
  // }

  // static Future<List<Note>> fatchNote({required String userid}) async {
  //   Uri requestUri = Uri.parse("$_baseUrl/list");
  //   var response = await http.post(
  //     requestUri,
  //     body: {"userid": userid},
  //   );
  //   var decoded = jsonDecode(response.body);
  //   List<Note> notes = [];
  //   for (var note in decoded) {
  //     Note newNote = Note.fromMap(note);
  //     notes.add(newNote);
  //   }
  //   return notes;
  // }

  static Future<List<DoctorModel>> doctorslist() async {
    List<DoctorModel> doctors = [];
    try {
      Uri requestUri = Uri.parse("$_baseUrl/list");
      var response = await http.post(requestUri);
      var decoded = jsonDecode(response.body);

      for (var doctor in decoded) {
        DoctorModel newDoctor = DoctorModel.fromMap(doctor);
        doctors.add(newDoctor);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return doctors;
  }
}
