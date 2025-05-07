import 'package:app_mochila/models/Item.dart';

class Category {
  final int id;
  final String name;
  final List<Item> items;

  Category({required this.id, required this.name, required this.items});
}
