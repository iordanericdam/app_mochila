// ignore_for_file: non_constant_identifier_names, file_names

class Item {
  int? id;
  int category_id;
  String name;
  String categoryName;
  int quantity;
  bool isChecked;

  Item({
    required this.quantity,
    required this.category_id,
    required this.name,
    this.categoryName = "",
    required this.isChecked,
    this.id,
  });

  // Getters
  int? get getId => id;
  int? get getCategoryId => category_id;
  String get getName => name;
  String? get getCategoryName => categoryName;

  // Setters
  set setCategoryId(int value) => category_id = value;
  set setName(String value) => name = value;
  set setCategoryName(String value) => categoryName = value;

  factory Item.fromJson(Map<String, dynamic> json) {
    print("DEBUG Item.fromJson: $json");

    return Item(
      id: json['id'],
      category_id: json['category_id'] ?? json['item_category_id'] ?? 0,
      categoryName:
          (json.containsKey('category_name') && json['category_name'] != null)
              ? json['category_name'].toString()
              : '',
      name: json['name']?.toString() ?? '',
      isChecked: (json['is_checked'] == 1 || json['is_checked'] == true),
      quantity: (json['quantity'] ?? 1) as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_checked': isChecked ? 1 : 0,
      'item_category_id': category_id,
      'name': name,
      'quantity': quantity,
    };
  }

  Item copyWith({
    int? id,
    String? name,
    int? quantity,
    int? category_id,
    String? categoryName,
    bool? isChecked,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category_id: category_id ?? this.category_id,
      categoryName: categoryName ?? this.categoryName,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
