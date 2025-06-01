import 'package:app_mochila/models/Trip.dart';

class TripFilterService {
  static List<Trip> filterTrips({
    required List<Trip> trips,
    required String searchText,
    required String selectedFilter,
    required bool isSearching,
    required bool showCompletedTrips,
    Map<int, String>? categoryNameMap,
  }) {
    final now = DateTime.now();
    List<Trip> result = trips;
    print(selectedFilter);
    // Filtrar por tipo de estado del viaje
    if (selectedFilter == 'Completados') {
      result = trips.where((trip) => trip.endDate.isBefore(now)).toList();
    } else if (selectedFilter == 'En curso') {
      result = trips
          .where((trip) =>
              trip.startDate.isBefore(now) && trip.endDate.isAfter(now))
          .toList();
    } else if (selectedFilter == 'Título') {
      result = trips;
    } else {
      result = trips
          .where((trip) =>
              trip.endDate.isAfter(now) || trip.endDate.isAtSameMomentAs(now))
          .toList();
    }
    print(result);
    // Aplicar búsqueda si se está escribiendo
    if (isSearching) {
      final search = searchText.toLowerCase();
      result = result.where((trip) {
        final inTitle = trip.name.toLowerCase().contains(search);
        final inDestination = trip.destination.toLowerCase().contains(search);
        final inCategory = categoryNameMap != null
            ? trip.categories.any((id) =>
                categoryNameMap[id]?.toLowerCase().contains(search) ?? false)
            : false;
        return inTitle || inDestination || inCategory;
      }).toList();
    }

    // Ordenar por fecha de inicio más próxima
    result.sort((a, b) => a.startDate.compareTo(b.startDate));

    return result;
  }
}
