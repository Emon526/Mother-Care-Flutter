import 'package:http/http.dart' as http;
import '../const/consts.dart';
import '../utils/exception_hander.dart';

class BreastCancerApiService {
  static const String _baseUrl = "${Consts.BASE_URL}/breastcancer";

  static Future articleslist() async {
    Uri requestUri = Uri.parse("$_baseUrl/articles");
    var response = await http.get(requestUri);
    var decoded = ExceptionHandlers.processResponse(response);
    return decoded;
  }
}
