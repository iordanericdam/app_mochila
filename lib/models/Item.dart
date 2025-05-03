// ignore_for_file: non_constant_identifier_names, file_names

class Item {
  int id;
  int category_id;
  String name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  String categoryName;
  int quantity;
  bool isChecked;

  Item({
    required this.id,
    required this.quantity,
    required this.category_id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    required this.categoryName,
    this.isChecked = false,
  });

  // Getters
  int get getId => id;
  int get getCategoryId => category_id;
  String get getName => name;
  String? get getDescription => description;
  DateTime? get getCreatedAt => createdAt;
  DateTime? get getUpdatedAt => updatedAt;
  String? get getCategoryName => categoryName;

  // Setters
  set setId(int value) => id = value;
  set setCategoryId(int value) => category_id = value;
  set setName(String value) => name = value;
  set setDescription(String? value) => description = value;
  set setCreatedAt(DateTime? value) => createdAt = value;
  set setUpdatedAt(DateTime? value) => updatedAt = value;
  set setCategoryName(String value) => categoryName = value;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      category_id: json['category_id'],
      categoryName: json['category_name'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': category_id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'category_name': categoryName,
    };
  }
}
