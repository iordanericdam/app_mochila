import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/services/api/Backpackapi.dart';

class BackpackService {
  static Future<Map<int, Backpack?>> loadBackpacks({
    required List<Trip> trips,
    required String token,
  }) async {
    final api = Backpackapi(token: token);
    Map<int, Backpack?> result = {};

    for (var trip in trips) {
      if (trip.id == null) continue;
      final tripBackpacks = await api.getBackpacksByTrip(trip.id!);
      result[trip.id!] = tripBackpacks.isNotEmpty ? tripBackpacks.first : null;
    }

    return result;
  }
}