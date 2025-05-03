import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/api/BackpackApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider global para BackpackApi
final backpackApiProvider = Provider<Backpackapi>((ref) {
  final user = ref.watch(userNotifierProvider);
  return user.when(
    data: (user) {
      return Backpackapi(token: user.token);
    },
    loading: () => throw Exception('User data is loading...'),
    error: (error, stackTrace) => throw Exception('Failed to load user data'),
  );
});

// BackpackNotifier: solo carga la mochila (Backpack)
class BackpackNotifier extends StateNotifier<AsyncValue<Backpack>> {
  BackpackNotifier(this.ref, {required this.tripId})
      : super(const AsyncLoading()) {
    loadBackpack();
  }

  final Ref ref;
  final int tripId;

  // Cargar la mochila de un viaje específico
  Future<void> loadBackpack() async {
    try {
      final backpack =
          await ref.read(backpackApiProvider).getBackpackByid(tripId);
      state = AsyncData(backpack);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Provider para BackpackNotifier
final backpackNotifierProvider =
    StateNotifierProvider.family<BackpackNotifier, AsyncValue<Backpack>, int>(
  (ref, tripId) => BackpackNotifier(ref, tripId: tripId),
);
