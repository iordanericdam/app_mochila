import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';

class TripApi extends APIService {
  TripApi({super.token, super.baseUrl});

  // get all trips
  Future<List<Trip>> getAllTrips() async {
    // Logger logger = Logger();
    try {
      final response = await getRequest('trips');

      List<dynamic> tripsJson = response.data;

      return tripsJson.map((json) => Trip.fromJson(json)).toList();
    } catch (e) {
      //logger.e("Error: $e");
      throw Exception('Failed to load trips');
    }
  }

  // get trips by user
  Future<List<Trip>> getTripsByUser() async {
    // Logger logger = Logger();
    try {
      final response = await getRequest('trips/by-user');

      List<dynamic> tripsJson = response.data;

      return tripsJson.map((json) => Trip.fromJson(json)).toList();
    } catch (e) {
      //logger.e("Error: $e");
      throw Exception('Failed to load trips');
    }
  }

  // get one trip
  Future<Trip> getTripById(int id) async {
    final response = await getRequest('trips/$id');
    return Trip.fromJson(response.data);
  }

// create a trip
Future<Trip> createTrip(Trip trip) async {
  try {
    final response = await postRequest('trips', trip.toJson());

    if (response.data != null) {
      return Trip.fromJson(response.data);
    }

    // ⚠️ Fallback si el backend no devuelve datos pero sí lo ha creado en BD
    final userTrips = await getTripsByUser();
    final matchedTrip = userTrips.firstWhere(
      (t) =>
          t.name == trip.name &&
          t.destination == trip.destination &&
          t.startDate == trip.startDate &&
          t.endDate == trip.endDate,
      orElse: () => throw Exception('Trip created but not found in list'),
    );

    return matchedTrip;
  } catch (e) {
    throw Exception('Failed to create trip: $e');
  }
}

  // update trip
  Future<Trip> updateTrip(int tripId, Map<String, dynamic> updateData) async {
    try {
      final response = await putRequest('trips/$tripId', updateData);
      return Trip.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update trip:$e');
    }
  }

  // delete trip
  Future<void> deleteTrip(int id) async {
    await deleteRequest('trips/$id');
  }

  // attatch categories
  Future<void> attachCategories(
      int tripId, Map<String, dynamic> updateData) async {
    await postRequest('trips/$tripId/categories/attach', updateData);
  }

  // attatch categories
  Future<void> detachCategories(
      int tripId, Map<String, dynamic> updateData) async {
    await postRequest('trips/$tripId/categories/detach', updateData);
  }
}
