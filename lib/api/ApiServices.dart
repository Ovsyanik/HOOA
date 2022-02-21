import 'package:http/http.dart' as http;

class ApiServices {
  static String uri = 'http://69a3-93-125-107-85.ngrok.io';
  Uri uri = Uri.parse(uri);

  static Future fetchInstitutions() async {
    return await http.get(url);
  }
}
