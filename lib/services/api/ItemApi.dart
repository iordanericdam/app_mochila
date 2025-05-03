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
      // Realizar la solicitud a la API
      final response = await getRequest('items/backpacks/$backpackId');
      final data = response.data;

      // Verificar si la respuesta contiene datos válidos
      if (data == null || data['item_categories'] == null) {
        print('No data or no item categories found');
        return [];
      }

      // Extraer y mapear los items de todas las categorías
      List<Item> allItems = [];
      for (var category in data['item_categories']) {
        for (var item in category['items'] ?? []) {
          print(category['id']);
          allItems.add(Item.fromJson({
            ...item, // Propiedades del item
            'category_id':
                category['id'] ?? 0, // Asignamos un valor predeterminado
            'category_name': category['name'] ??
                'Unknown', // Asignamos 'Unknown' si no existe el nombre
          }));
        }
      }

      return allItems;
    } catch (e) {
      print('Error fetching items: $e');
      return [];
    }
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

  addItem(int backpackId, Item item) {}
}
