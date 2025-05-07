class ItemCategory {
  final int id;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ItemCategory({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
