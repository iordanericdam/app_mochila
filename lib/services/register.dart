import 'dart:convert';

import 'package:app_mochila/services/common.dart';
import 'package:http/http.dart' as http;

class Register {
  static Future<Map<String, dynamic>?> register(
      String email, String password, String name, {String? lastName, String? phone}) async {
    var url = Uri.parse('${Common.baseUrl}/register');
    var headers = Common.headers;
    var body = json.encode({
      "email": email,
      "password": password,
      "name": name,
      //"lastName": lastName,
      //"phone": phone 
      //""
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
