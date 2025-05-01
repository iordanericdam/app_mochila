import 'dart:convert';
import 'package:http/http.dart' as http;

class APIService {
  final String? token;
  final String baseUrl;

  APIService({this.baseUrl = 'https://uemproyecto.site/api', this.token});

  Map<String, String> get headers {
    if (token != null) {
      return {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
    }
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  // _parseResponse
  ApiResult _parseResponse(http.Response response) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (!jsonResponse.containsKey('data')) {
        return ApiResult(
            success: false, message: 'Response missing "data" field');
      }
      return ApiResult(success: true, data: jsonResponse['data']);
    } else {
      final errorMessage = jsonResponse['message'] ?? 'Unknown error';
      final errorDetails = jsonResponse['error'] ?? 'No details';
      final errorCode = jsonResponse['code'] ?? response.statusCode;

      return ApiResult(
        success: false,
        message: 'Error $errorCode: $errorMessage - $errorDetails',
      );
    }
  }

  // GET
  Future<ApiResult> getRequest(String endpoint) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);

      return _parseResponse(response);
    } catch (e) {
      return ApiResult(success: false, message: 'Failed to get data: $e');
    }
  }

  // POST
  Future<ApiResult> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: json.encode(data),
      );
      return _parseResponse(response);
    } catch (e) {
      return ApiResult(success: false, message: 'Failed to post data: $e');
    }
  }

  // PUT
  Future<ApiResult> putRequest(
      String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: json.encode(data),
      );
      return _parseResponse(response);
    } catch (e) {
      return ApiResult(success: false, message: 'Failed to update data: $e');
    }
  }

  // DELETE
  Future<ApiResult> deleteRequest(String endpoint) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/$endpoint'), headers: headers);
      return _parseResponse(response);
    } catch (e) {
      return ApiResult(success: false, message: 'Failed to delete data: $e');
    }
  }
}

class ApiResult {
  final bool success;
  final dynamic data;
  final String? message;

  ApiResult({required this.success, this.data, this.message});
}
