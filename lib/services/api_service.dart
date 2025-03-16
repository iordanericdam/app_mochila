import 'dart:convert';
import 'package:app_mochila/services/common.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Método para verificar si un email existe en el sistema
  static Future<Map<String, dynamic>?> checkEmail(String email) async {
    var url = Uri.parse('${Common.baseUrl}/check-email');
    var headers = Common.headers;
    var body = json.encode({"email": email});
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

// Método para enviar un código de restablecimiento de contraseña al correo electrónico
  static Future<void> sendResetPasswordCode(String email) async {
    // Definir los encabezados de la solicitud
    var headers = Common.headers;

    // Crear la solicitud HTTP de tipo POST para la API de restablecimiento de contraseña
    var request = http.Request('POST',
        Uri.parse('https://uemproyecto.site/api/send-reset-password-code'));

    // Definir el cuerpo de la solicitud (el email del usuario)
    request.body = json.encode({
      "email": email,
    });

    // Agregar los encabezados a la solicitud
    request.headers.addAll(headers);

    // Enviar la solicitud y esperar la respuesta
    http.StreamedResponse response = await request.send();

    // Comprobar si la respuesta fue exitosa (código de estado 200)
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, imprimir el cuerpo de la respuesta
      print(await response.stream.bytesToString());
    } else {
      // Si la respuesta no fue exitosa, imprimir el mensaje de error
      print(response.reasonPhrase);
    }
  }

  // Método para verificar el código de restablecimiento de contraseña
  static Future<Map<String, dynamic>?> verifyResetPasswordCode(
      String email, String code) async {
    var url = Uri.parse('${Common.baseUrl}/verify-reset-password-code');
    var headers = Common.headers;
    var body = json.encode({
      "email": email,
      "code": code,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      // Si la respuesta es exitosa, devolver el cuerpo de la respuesta decodificado
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Excepción: $e');
      return null;
    }
  }

  // Método para restablecer la contraseña
  static Future<Map<String, dynamic>?> resetPassword(
      String email, String code, String newPassword) async {
    var url = Uri.parse('${Common.baseUrl}/reset-password');
    var headers = Common.headers;
    var body = json.encode({
      "email": email,
      "code": code,
      "password": newPassword,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);

      // Si la respuesta es exitosa, devolver el cuerpo de la respuesta decodificado
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Excepción: $e');
      return null;
    }
  }
}
