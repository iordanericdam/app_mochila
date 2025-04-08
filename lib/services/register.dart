import 'dart:convert';

import 'package:app_mochila/services/common.dart';
import 'package:http/http.dart' as http;

class Register {
  static Future<Map<String, dynamic>?> register(String email, String password,
      String name, String username, String phone) async {
    var url = Uri.parse('${Common.baseUrl}/register');
    var headers = Common.headers;
    var userData;
    if (phone == '') {
      userData = {
        "email": email,
        "password": password,
        "name": name,
        "username": username,
      };
    } else {
      userData = {
        "email": email,
        "password": password,
        "name": name,
        "telefono": phone,
        "username": username,
      };
    }
    var body = json.encode(userData);

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

  static Future<Map<String, dynamic>?> checkNickname(String nickname) async {
    var url = Uri.parse('${Common.baseUrl}/check-nickname');
    var headers = Common.headers;
    var body = json.encode({"nickname": nickname});

    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("fail: ${response.body}");
        return null;
      }
    } catch (e) {
      print("fail: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>?> checkUserName(String userName) async {
    var url = Uri.parse('${Common.baseUrl}/check-username');
    var headers = Common.headers;
    var body = json.encode({"username": userName});
    try {
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("fail: ${response.body}");
        return null;
      }
    } catch (e) {
      print("fail: $e");
      return null;
    }
  }
}
