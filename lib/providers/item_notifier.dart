import 'package:app_mochila/models/Item.dart';
import 'package:app_mochila/providers/user_notifier.dart';
import 'package:app_mochila/services/api/ItemApi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider global para ItemApi
final itemApiProvider = Provider<ItemApi>((ref) {
  final user = ref.watch(userNotifierProvider);
  return user.when(
    data: (user) {
      return ItemApi(token: user.token);
    },
    loading: () => throw Exception('User data is loading...'),
    error: (error, stackTrace) => throw Exception('Failed to load user data'),
  );
});

// ItemNotifier para manejar la lista de ítems en una mochila
class ItemNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  ItemNotifier(this.ref, {required this.backpackId})
      : super(const AsyncLoading()) {
    loadItems();
  }

  final Ref ref;
  final int backpackId;

  // Cargar los ítems de la mochila
  Future<void> loadItems() async {
    try {
      final items =
          await ref.read(itemApiProvider).getItemsByBackpack(backpackId);
      state = AsyncData(items);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Añadir un nuevo ítem a la mochila
  Future<void> addItem(Item item) async {
    try {
      final newItem = await ref.read(itemApiProvider).addItem(backpackId, item);
      state = AsyncData([...state.value ?? [], newItem]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Actualizar un ítem existente
  Future<void> updateItem(int itemId, Map<String, dynamic> data) async {
    try {
      final updatedItem =
          await ref.read(itemApiProvider).updateItem(itemId, data);
      final updatedList = (state.value ?? [])
          .map((item) => item.id == itemId ? updatedItem : item)
          .toList();
      state = AsyncData(updatedList);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Eliminar un ítem de la mochila
  Future<void> deleteItem(int itemId) async {
    try {
      await ref.read(itemApiProvider).deleteItem(itemId);
      final newList =
          (state.value ?? []).where((item) => item.id != itemId).toList();
      state = AsyncData(newList);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final itemNotifierProvider =
    StateNotifierProvider.family<ItemNotifier, AsyncValue<List<Item>>, int>(
  (ref, backpackId) => ItemNotifier(ref, backpackId: backpackId),
);
