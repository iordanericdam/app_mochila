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

class ItemNotifier extends StateNotifier<AsyncValue<List<Item>>> {
  ItemNotifier(this.ref, {required this.backpackId})
      : super(const AsyncLoading()) {
    loadItems();
  }

  final Ref ref;
  final int backpackId;

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
      final newItem = await ref.read(itemApiProvider).createItem(item);
      state = AsyncData([...state.value ?? [], newItem]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Actualizar un ítem existente
  Future<void> updateItem(Item item) async {
    try {
      final updatedItem = await ref.read(itemApiProvider).updateItem(item);

      // Preserve categoryName if API response doesn't include it
      final itemWithCategory =
          updatedItem.copyWith(categoryName: item.categoryName);

      final updatedList = (state.value ?? [])
          .map((existingItem) =>
              existingItem.id == item.id ? itemWithCategory : existingItem)
          .toList();

      state = AsyncData(updatedList);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Cambiar el estado isChecked de un ítem
  Future<void> toggleChecked(Item item) async {
    try {
      // 1. Crear una copia local con isChecked cambiado, sin perder categoryName
      final updatedItem = item.copyWith(
        isChecked: !item.isChecked,
      );

      // 2. Enviar al backend
      final result = await ref.read(itemApiProvider).updateItem(updatedItem);

      // Mantener el nombre de categoría local si la respuesta no lo incluye
      final itemWithCategory =
          result.copyWith(categoryName: item.categoryName);

      // 3. Reconstruir la lista con el nuevo ítem actualizado
      final updatedList = (state.value ?? []).map((existingItem) {
        return existingItem.id == itemWithCategory.id
            ? itemWithCategory
            : existingItem;
      }).toList();

      // 4. Actualizar el estado
      state = AsyncData(updatedList);
    } catch (e, st) {
      print("Error en toggleChecked: $e");
      state = AsyncError(e, st);
    }
  }

  // Eliminar un ítem de la mochila
  Future<void> deleteItem(int? itemId) async {
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
