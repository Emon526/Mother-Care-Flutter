import 'package:http/http.dart' as http;
import '../const/consts.dart';
import '../utils/exception_hander.dart';

class ApiService {
  static const String _baseUrl = Consts.BASE_URL;

  static Future apirequest() async {
    Uri requestUri = Uri.parse(_baseUrl);
    var response = await http.get(requestUri);
    var decoded = ExceptionHandlers.processResponse(response);
    return decoded;
  }
}
