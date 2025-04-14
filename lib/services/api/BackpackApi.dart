import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';
import 'package:http/http.dart';

class Backpackapi extends APIService {
  Backpackapi({super.token, super.baseUrl});
  // get all backpacks
  Future<List<Backpack>> getAllBackpacks() async {
    final response = await getRequest('backpacks');
    List<dynamic> backpacksJson = response.data;
    return backpacksJson.map((json) => Backpack.fromJson(json)).toList();
  }

  Future<Backpack> getBackpackByid(int backpack_id) async {
    final response = await getRequest('backpacks/$backpack_id');
    return Backpack.fromJson(response.data);
  }

  Future<List<Backpack>> getBackpacksByUser() async {
    final response = await getRequest('backpacks/by-user');
    List<dynamic> backpacksJson = response.data;
    return backpacksJson.map((json) => Backpack.fromJson(json)).toList();
  }

  Future<List<Backpack>> getBackpacksByTrip(int trip_id) async {
    final response = await getRequest('backpacks/trip/$trip_id');
    List<dynamic> backpacksJson = response.data;
    return backpacksJson.map((json) => Backpack.fromJson(json)).toList();
  }

  Future<Backpack> createBackpack(Backpack backpack) async {
    final response = await postRequest('backpacks', backpack.toJson());
    return Backpack.fromJson(response.data);
  }

  Future<Backpack> updateBackpack(
      int backpackId, Map<String, dynamic> updateData) async {
    final response = await putRequest('backpacks/$backpackId', updateData);
    return Backpack.fromJson(response.data);
  }

  Future<Backpack> deleteBackpack(int backpackId) async {
    final response = await deleteRequest('backpacks/$backpackId');
    return Backpack.fromJson(response.data);
  }
}
