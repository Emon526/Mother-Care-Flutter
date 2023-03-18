import 'package:http/http.dart' as http;
import '../const/consts.dart';
import '../utils/exception_hander.dart';

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

  // static Future<List<DoctorModel>> doctorslist() async {
  //   List<DoctorModel> doctors = [];
  //   try {
  //     Uri requestUri = Uri.parse("$_baseUrl/lis");
  //     var response = await http.post(requestUri);
  //     var decoded = ExceptionHandlers.processResponse(response);
  //     for (var doctor in decoded) {
  //       DoctorModel newDoctor = DoctorModel.fromMap(doctor);
  //       doctors.add(newDoctor);
  //     }
  //     return doctors;
  //   } catch (e) {
  //     // debugPrint(e.toString());
  //     throw e.toString();
  //     // throw ExceptionHandlers.getExceptionString(e);
  //   }
  // }

  static Future doctorslist() async {
    Uri requestUri = Uri.parse("$_baseUrl/list");
    var response = await http.post(requestUri);
    var decoded = ExceptionHandlers.processResponse(response);
    return decoded;
  }
}
