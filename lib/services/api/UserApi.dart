import 'package:app_mochila/models/User.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';

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
}
