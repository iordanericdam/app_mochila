import 'package:app_mochila/models/ItemCategory.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';

class ItemCategoryApi extends APIService {
  ItemCategoryApi({super.token, super.baseUrl});

  Future<List<ItemCategory>> getAllCategories() async {
    final response = await getRequest('item_categories');
    List<dynamic> itemCategoriesJson = response.data;
    return itemCategoriesJson
        .map((json) => ItemCategory.fromJson(json))
        .toList();
  }

  Future<ItemCategory> getCategoryByid(int itemCategoryId) async {
    final response = await getRequest('item_categories/$itemCategoryId');
    return ItemCategory.fromJson(response.data);
  }

  Future<ItemCategory> createCategory(ItemCategory itemCategory) async {
    final response =
        await postRequest('item_categories', itemCategory.toJson());
    return ItemCategory.fromJson(response.data);
  }

  Future<ItemCategory> updateCategory(
      int categoryId, Map<String, dynamic> updateData) async {
    final response =
        await postRequest('item_categories/$categoryId', updateData);
    return ItemCategory.fromJson(response.data);
  }

  Future<ItemCategory> deleteCategoryByid(int itemCategoryId) async {
    final response = await deleteRequest('item_categories/$itemCategoryId');
    return ItemCategory.fromJson(response.data);
  }
}
