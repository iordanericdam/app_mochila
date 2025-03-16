import 'dart:convert';

import 'package:app_mochila/services/common.dart';
import 'package:http/http.dart' as http;

class Login {
  // Es un método asíncrono (async) porque realiza una solicitud HTTP.
// ¿Simpre usa Future con async? Cuando declaras una función que realiza una operación asíncrona y quieres usar await dentro de ella, debes marcarla con async.
// Devuelve un Future<Map<String, dynamic>?>, lo que significa que retorna un JSON convertido en mapa (Map) si la respuesta es correcta, o null si hay error.
  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    var url = Uri.parse('${Common.baseUrl}/login');
    var headers = Common.headers;
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
}
