import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/models/ItemCategory.dart';
import 'package:app_mochila/services/api/ItemCategoryApi.dart';
import 'package:app_mochila/providers/user_notifier.dart';

final itemCategoryApiProvider = Provider<ItemCategoryApi>((ref) {
  final user = ref.watch(userNotifierProvider);
  return user.when(
    data: (user) => ItemCategoryApi(token: user.token),
    loading: () => throw Exception('User data is loading...'),
    error: (error, stackTrace) => throw Exception('Failed to load user data'),
  );
});

class ItemCategoryNotifier extends StateNotifier<AsyncValue<List<ItemCategory>>> {
  ItemCategoryNotifier(this.ref) : super(const AsyncLoading()) {
    loadCategories();
  }

  final Ref ref;

  Future<void> loadCategories() async {
    try {
      final categories = await ref.read(itemCategoryApiProvider).getAllCategories();
      state = AsyncData(categories);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addCategory(String name, {String? description}) async {
    try {
      final newCategory = await ref.read(itemCategoryApiProvider).createCategory(
        ItemCategory(id: 0, name: name, description: description),
      );
      state = AsyncData([...state.value ?? [], newCategory]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final itemCategoryNotifierProvider =
    StateNotifierProvider<ItemCategoryNotifier, AsyncValue<List<ItemCategory>>>(
  (ref) => ItemCategoryNotifier(ref),
);
