import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  Future getData(String url) async {
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
