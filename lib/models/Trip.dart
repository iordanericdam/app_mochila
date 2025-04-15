class Trip {
  final int? id;
  final int? userId;
  final String name;
  final String? description;
  final String destination;
  final String temperature;
  //final String activityType;
  final DateTime startDate;
  final DateTime endDate;
  final String? urlPhoto;

  Trip({
    this.id,
    this.userId,
    required this.name,
    this.description,
    required this.destination,
    required this.temperature,
    //required this.activityType,
    required this.startDate,
    required this.endDate,
    this.urlPhoto,
  });

  // Convertir desde JSON hasta Trip dataModel
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      destination: json['destination'],
      temperature: json['temperature'],
      //activityType: json['activity_type'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      urlPhoto: json['url_photo'],
    );
  }

  // Convertir desde Trip dataModel hasta  JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'destination': destination,
      'temperature': temperature,
      //'activity_type': activityType,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'url_photo': urlPhoto,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Trip{id: $id, userId: $userId, name: $name, description: $description, destination: $destination, temperature: $temperature,  startDate: $startDate, endDate: $endDate, urlPhoto: $urlPhoto}';
  }
}
