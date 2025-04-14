class Backpack {
  final int? id;
  final int tripId;
  final int colorId;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Backpack({
    this.id,
    required this.tripId,
    required this.colorId,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Backpack.fromJson(Map<String, dynamic> json) {
    return Backpack(
      id: json['id'],
      tripId: json['trip_id'],
      colorId: json['color_id'] ?? 1,
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
      'trip_id': tripId,
      'color_id': colorId,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Backpack{id: $id, tripId: $tripId, colorId: $colorId, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
