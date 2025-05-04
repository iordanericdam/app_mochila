import 'package:app_mochila/models/Trip.dart';

class TripFilterService {
  static List<Trip> filterTrips({
    required List<Trip> trips,
    required String searchText,
    required String selectedFilter,
    required bool isSearching,
    required bool showCompletedTrips,
  }) {
    final now = DateTime.now();
    List<Trip> result = trips;

     // Filtrar por tipo de estado del viaje
    if (selectedFilter == 'Completados') {
      result = trips.where((trip) => trip.endDate.isBefore(now)).toList();
    } else if (selectedFilter == 'En curso') {
      result = trips.where((trip) =>
        trip.startDate.isBefore(now) &&
        trip.endDate.isAfter(now)).toList();
    } else {  //Devuelve todos los viajes en curso
      result = trips.where((trip) =>
        trip.endDate.isAfter(now) || trip.endDate.isAtSameMomentAs(now)).toList();
    }

    // Aplicar búsqueda si escribe algo en la barra de búsqueda
    if (isSearching) {
      final search = searchText.toLowerCase();
      result = result.where((trip) {
        final inTitle = trip.name.toLowerCase().contains(search);
        final inDestination = trip.destination.toLowerCase().contains(search);
        final categories = trip.toJson()['categories'];
        final inCategory = categories is List
            ? categories.any((cat) =>
                (cat['name'] as String).toLowerCase().contains(search))
            : false;
        return inTitle || inDestination || inCategory;
      }).toList();
    }

    // Ordenar por fecha de inicio más próxima
    result.sort((a, b) => a.startDate.compareTo(b.startDate));

    return result;
  }
}