import 'dart:convert';
import 'dart:io';

import 'package:app_mochila/models/User.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UserApi extends APIService {
  UserApi({super.token, super.baseUrl});
  Future<User?> login(Map<String, dynamic> userData) async {
    final response = await postRequest('login', userData);
    if (response.success) {
      return User.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    final response = await postRequest("register", userData);
    print(response.message);
    return response.success;
  }

  Future<bool> sendRegisterCode(Map<String, dynamic> email) async {
    final response = await postRequest('send-register-code', email);
    return response.success;
  }

  Future<bool> vertifierRegisterCode(Map<String, dynamic> data) async {
    final response = await postRequest("verify-register-code", data);
    // print(response.message);
    return response.success;
  }

  Future<User?> registerWithPhoto({
    required Map<String, dynamic> userData,
    required File? imageFile,
  }) async {
    try {
      var uri = Uri.parse('$baseUrl/register');
      var request = http.MultipartRequest('POST', uri);

      userData.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imageFile != null) {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'url_photo',
          stream,
          length,
          filename: basename(imageFile.path),
        );
        request.files.add(multipartFile);
      }

      request.headers['Accept'] = 'application/json';

      var response = await request.send();
      var respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(respStr);
        if (decoded['data'] != null) {
          return User.fromJson(decoded['data']);
        }
      } else {
        print('Error: ${respStr}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<User?> updateProfile({
    required Map<String, dynamic> userData,
    required File? imageFile,
  }) async {
    try {
      var uri = Uri.parse('$baseUrl/update-profile');
      var request = http.MultipartRequest('POST', uri);

      userData.forEach((key, value) {
        request.fields[key] = value;
      });

      if (imageFile != null) {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'url_photo',
          stream,
          length,
          filename: basename(imageFile.path),
        );
        request.files.add(multipartFile);
      }

      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();
      var respStr = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(respStr);
        if (decoded['data'] != null) {
          print(decoded['data']);
          return User.fromJson(decoded['data']);
        }
      } else {
        print('Error: ${respStr}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
