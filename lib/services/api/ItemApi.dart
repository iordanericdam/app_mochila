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
    final response = await getRequest('items/backpacks/$backpackId');
    List<dynamic> itemsJson = response.data;
    return itemsJson.map((json) => Item.fromJson(json)).toList();
  }

  Future<Item> createItem(Item item) async {
    final response = await postRequest('items', item.toJson());
    return Item.fromJson(response.data);
  }

  Future<Item> updateItem(int itemId, Map<String, dynamic> updateData) async {
    final response = await putRequest('items/$itemId', updateData);
    return Item.fromJson(response.data);
  }

  Future<Item> deleteItem(int itemId) async {
    final response = await deleteRequest('backpacks/$itemId');
    return Item.fromJson(response.data);
  }
}
