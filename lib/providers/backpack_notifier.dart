import 'package:app_mochila/models/Backpack.dart';
import 'package:app_mochila/services/api/BackpackApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/providers/user_notifier.dart';

final backpackApiProvider = Provider<Backpackapi>((ref) {
  final user = ref.watch(userNotifierProvider);
  return user.when(
      data: (user) {
        return Backpackapi(token: user.token);
      },
      error: (error, stackTrace) => throw Exception('Failed to load user data'),
      loading: () => throw Exception('User data is loading...'));
});

class BackpackNotifier extends StateNotifier<AsyncValue<List<Backpack>>> {
  final Ref ref;

  BackpackNotifier(this.ref) : super(const AsyncLoading()) {
    loadBackpacks();
  }

  Future<void> loadBackpacks() async {
    try {
      final backpacks =
          await ref.read(backpackApiProvider).getBackpacksByUser();
      state = AsyncData(backpacks);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
