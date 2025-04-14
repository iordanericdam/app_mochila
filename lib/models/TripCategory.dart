class TripCategory {
  final int id;
  final int tripId;
  final String name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TripCategory({
    required this.id,
    required this.tripId,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  // Crear una instancia de TripCategory desde JSON
  factory TripCategory.fromJson(Map<String, dynamic> json) {
    return TripCategory(
      id: json['id'],
      tripId: json['trip_id'],
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

  // Convertir la instancia en un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trip_id': tripId,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
