import 'package:app_mochila/models/Item.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';

class ItemApi extends APIService {
  ItemApi({super.token, super.baseUrl});

  Future<List<Item>> getAllItems() async {
    final response = await getRequest('items');
    List<dynamic> itemsJson = response.data;
    return itemsJson.map((json) => Item.fromJson(json)).toList();
  }

  Future<Item> getItemByid(int itemId) async {
    final response = await getRequest('items/$itemId');
    return Item.fromJson(response.data);
  }

  Future<List<Item>> getItemsByBackpack(int backpackId) async {
    try {
      final response = await getRequest('items/backpacks/$backpackId');
      final data = response.data;

      if (data == null || data['item_categories'] == null) {
        return [];
      }

      List<Item> allItems = [];
      for (var category in data['item_categories']) {
        for (var item in category['items'] ?? []) {
          allItems.add(Item.fromJson({
            ...item,
            'category_id': category['id'] ?? 0,
            'category_name': category['name'] ?? 'Unknown',
            'is_checked': item['is_checked'] ?? false,
          }));
        }
      }
      return allItems;
    } catch (e) {
      return [];
    }
  }

  Future<Item> createItem(Item item) async {
    final response = await postRequest('items', item.toJson());
    return Item.fromJson(response.data);
  }

  Future<Item> updateItem(Item item) async {
    final response = await putRequest('items/${item.id}', item.toJson());
    return Item.fromJson(response.data);
  }

  Future<Item> deleteItem(int? itemId) async {
    final response = await deleteRequest('items/$itemId');
    return Item.fromJson(response.data);
  }
}
