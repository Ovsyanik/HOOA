import 'package:http/http.dart' as http;

class ApiServices {
  static Uri uri = Uri.parse('http://69a3-93-125-107-85.ngrok.io');

  static Future fetchInstitutions() async {
    return await http.get(uri);
  }
}
