import 'package:app_mochila/models/Trip.dart';

class TripFilterService {
  static List<Trip> filterTrips({
    required List<Trip> trips,
    required String searchText,
    required String selectedFilter,
    required bool isSearching,
    //required bool showCompletedTrips,
    Map<int, String>? categoryNameMap,
  }) {
    final now = DateTime.now(); //Obtener la fecha y hora actual y la convertimos a fecha sin hora ni minutos ni segundos.
    final today = DateTime(now.year, now.month, now.day);
    List<Trip> result = trips;
    //print(selectedFilter);

    // Filtrar por tipo de estado del viaje
    if (selectedFilter == 'Completados') {
      result = trips.where((trip) => trip.endDate.isBefore(today)).toList(); // Filtrar viajes que terminaron antes de hoy
    } else if (selectedFilter == 'Planificados') {
      result = trips
          .where((trip) =>
              trip.endDate.isAfter(today)||trip.endDate.isAtSameMomentAs(today)) // Filtrar viajes que terminan hoy o en el futuro
          .toList();
    } else {
      result = List.from(trips);
    }

    //print(result);
    // Aplicar búsqueda si se está escribiendo
    if (isSearching) {
      final search = searchText.toLowerCase();
      result = result.where((trip) {
        final inTitle = trip.name.toLowerCase().contains(search);
        final inDestination = trip.destination.toLowerCase().contains(search);
        // final inCategory = categoryNameMap != null
        //    ? trip.categories.any((id) =>
        //         categoryNameMap[id]?.toLowerCase().contains(search) ?? false)
        //     : false;
        return inTitle || inDestination;
      }).toList();
    }

    //Ordenar por fecha de inicio más próxima
    result.sort((a, b) => a.startDate.compareTo(b.startDate));

    return result;
  }
}
