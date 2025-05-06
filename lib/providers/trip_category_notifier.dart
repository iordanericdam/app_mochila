import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_mochila/data/category_data.dart';
import 'package:app_mochila/services/api/TripCategoryApi.dart';
import 'package:app_mochila/providers/user_notifier.dart';

class TripCategoryNotifier extends StateNotifier<AsyncValue<List<CategoryData>>> {
  TripCategoryNotifier(this.ref) : super(const AsyncLoading()) {
    loadCategories(); // Se carga al iniciarse
  }

  final Ref ref;

  Future<void> loadCategories() async {
    try {
      final user = ref.read(userNotifierProvider).value;
      final api = TripCategoryApi(token: user!.token);
      final categories = await api.getCategoryDataList();
      state = AsyncData(categories);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

final tripCategoryNotifierProvider =
    StateNotifierProvider<TripCategoryNotifier, AsyncValue<List<CategoryData>>>(
  (ref) => TripCategoryNotifier(ref),
);