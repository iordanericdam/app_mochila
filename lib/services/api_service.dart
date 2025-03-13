import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://uemproyecto.site/api';

// Es un método asíncrono (async) porque realiza una solicitud HTTP.
// ¿Simpre usa Future con async? Cuando declaras una función que realiza una operación asíncrona y quieres usar await dentro de ella, debes marcarla con async.
// Devuelve un Future<Map<String, dynamic>?>, lo que significa que retorna un JSON convertido en mapa (Map) si la respuesta es correcta, o null si hay error.
  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var body = json.encode({"email": email, "password": password});

    try {
      // await → Hace que el código espere hasta que se reciba la respuesta.
      var response = await http.post(url, headers: headers, body: body);
      // Manejo de la respuesta
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      // Si ocurre un error de conexión o servidor, el catch captura la excepción y devuelve null.
      print('Exception: $e');
      return null;
    }
  }

  /// Método para verificar si un email existe en el sistema
  static Future<Map<String, dynamic>?> checkEmail(String email) async {
    var url = Uri.parse('$baseUrl/check-email');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
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
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

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
    var url = Uri.parse('$baseUrl/verify-reset-password-code');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
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
    var url = Uri.parse('$baseUrl/reset-password');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
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
