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

    // Filtrar por viajes completados o activos
    if (selectedFilter == 'Completados' || showCompletedTrips) {
      result = result.where((trip) => trip.endDate.isBefore(now)).toList();
    } else {
      result = result.where((trip) => trip.endDate.isAfter(now) || trip.endDate.isAtSameMomentAs(now)).toList();
    }

    // Aplicar búsqueda si hay texto
    if (isSearching && selectedFilter != 'Todos' && selectedFilter != 'Completados') {
      final search = searchText.toLowerCase();
      result = result.where((trip) {
        switch (selectedFilter) {
          case 'Título':
            return trip.name.toLowerCase().contains(search);
          case 'Destino':
            return trip.destination.toLowerCase().contains(search);
          case 'Categoría':
            final categories = trip.toJson()['categories'];
            if (categories is List) {
              return categories.any((cat) =>
                  (cat['name'] as String).toLowerCase().contains(search));
            }
            return false;
          default:
            return true;
        }
      }).toList();
    }

    // Ordenar por fecha de inicio más próxima
    result.sort((a, b) => a.startDate.compareTo(b.startDate));

    return result;
  }
}