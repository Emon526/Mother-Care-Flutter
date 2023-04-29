import 'dart:convert';
import 'package:http/http.dart' as http;
import '../const/consts.dart';
import '../models/doctormodel.dart';
import '../utils/exception_hander.dart';

class DoctorsApiService {
  static const String _baseUrl = "${Consts.BASE_URL}/doctors";

  static Future<List<DoctorModel>> doctorslist() async {
    try {
      var requestUri = Uri.parse("$_baseUrl/list");
      var request = await http.post(requestUri);
      var response = ExceptionHandlers.processResponse(request);
      var decodeddoctorsList = jsonDecode(response.body)['doctors'];
      List<DoctorModel> doctorList = [];
      for (var doctor in decodeddoctorsList) {
        DoctorModel newDoctor = DoctorModel.fromMap(doctor);
        doctorList.add(newDoctor);
      }
      return doctorList;
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }
  }
}
