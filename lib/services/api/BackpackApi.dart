import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Backpackapi extends APIService {
  Backpackapi({super.token, super.baseUrl});
  // get all backpacks
  Future<List<Backpack>> getAllBackpacks() async {
    final response = await getRequest('backpacks');
    List<dynamic> backpacksJson = response.data;
    return backpacksJson.map((json) => Backpack.fromJson(json)).toList();
  }

  Future<Backpack> getBackpackByid(int backpackId) async {
    final response = await getRequest('backpacks/$backpackId');
    return Backpack.fromJson(response.data);
  }

  Future<List<Backpack>> getBackpacksByUser() async {
    final response = await getRequest('backpacks/by-user');
    List<dynamic> backpacksJson = response.data;
    return backpacksJson.map((json) => Backpack.fromJson(json)).toList();
  }

  Future<List<Backpack>> getBackpacksByTrip(int tripId) async {
    final response = await getRequest('backpacks/trip/$tripId');
    // Verifica si la respuesta es nula o no es una lista
    if (response.data == null || response.data is! List) {
      //debugPrint("Respuesta : ${response.data.runtimeType}");
      return [];
    }
    List<dynamic> backpacksJson = response.data;
    return backpacksJson.map((json) => Backpack.fromJson(json)).toList();
  }

  Future<List<Backpack>> getBackpackByTrip(int tripId) async {
    final response = await getRequest('backpacks/trip/backpack/$tripId');
    // Verifica si la respuesta es nula o no es una lista
    if (response.data == null || response.data is! List) {
      //debugPrint("Respuesta : ${response.data.runtimeType}");
      return [];
    }
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
