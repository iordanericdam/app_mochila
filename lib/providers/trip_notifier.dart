import 'package:app_mochila/models/Trip.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/api/TripApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Crear variable global para guardar un objeto "TripApi"
final tripApiProvider = Provider<TripApi>((ref) {
  final user = ref.watch(userNotifierProvider);
  return user.when(
    data: (user) {
      return TripApi(token: user.token);
    },
    loading: () => throw Exception('User data is loading...'),
    error: (error, stackTrace) => throw Exception('Failed to load user data'),
  );

  //return TripApi(token: '2|8yTPfrPeH2FCOfnZFWYEnOahFAZBDmPSGz7h2Gu6f072e40e');
});

// 1. Crear StateNotifier para Trips
class TripNotifier extends StateNotifier<AsyncValue<List<Trip>>> {
  // Es una funcion constructor,
  // primera vez iniciar esto, ejecuta loadTrips().
  // loadTrips() puede llamar la api para obtener los viajes del usuario logged
  TripNotifier(this.ref) : super(const AsyncLoading()) {
    loadTrips();
  }

  final Ref ref;

  Future<void> loadTrips() async {
    try {
      final trips = await ref.read(tripApiProvider).getTripsByUser();
      // state es una propiedad proporcionada por la clase StateNotifier.
      // En este caso: el tipo de state es AsyncValue<List<Trip>>, es decir, state puede guarda la lista de modelo Trip
      // state = AsyncData(trips); es devir, Almacena la lista Trip en state
      state = AsyncData(trips);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> createTrip(Trip trip) async {
    try {
      final newTrip = await ref.read(tripApiProvider).createTrip(trip);
      // Añadir viaje nuevo a state
      state = AsyncData([...state.value ?? [], newTrip]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateTrip(int id, Map<String, dynamic> data) async {
    try {
      final updatedTrip = await ref.read(tripApiProvider).updateTrip(id, data);
      // Actualizar el viaje de base de datos mientras actualizar el viaje corresponde en state
      final updatedList =
          (state.value ?? []).map((t) => t.id == id ? updatedTrip : t).toList();
      state = AsyncData(updatedList);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteTrip(int id) async {
    try {
      // Misma logica: Eliminar en bbdd mientras eliminar en state
      await ref.read(tripApiProvider).deleteTrip(id);
      final newList =
          (state.value ?? []).where((trip) => trip.id != id).toList();
      state = AsyncData(newList);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// 2. Definir Provider
// 2.1 Introduccion
// encapsular la lógica de negocio y el estado en un StateNotifier,
// y luego exponerlo a través de un StateNotifierProvider.
// Así, la UI  puede simplemente observar y consumir el estado, sin tener que preocuparse por la lógica interna
// (como hacer peticiones a la API, manejar errores, o manipular el estado).

// 2.2 Resumen
// Registra el notificador en Riverpod para que pueda ser observado y utilizado en cualquier parte de la UI.

// 2.3 Ejemplo de uso en UI:
// final tripsState = ref.watch(tripNotifierProvider);
//  ref.read(tripNotifierProvider.notifier)

final tripNotifierProvider =
    StateNotifierProvider<TripNotifier, AsyncValue<List<Trip>>>(
  (ref) => TripNotifier(ref),
);
