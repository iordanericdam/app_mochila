class Setupbptrip {
  final String titulo;
  final String descripcion;
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String? categoria;

  Setupbptrip({
    required this.titulo,
    required this.descripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.categoria,
  });

  factory Setupbptrip.fromJson(Map<String, dynamic> json) {
    return Setupbptrip(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
      fechaFin: DateTime.parse(json['fechaFin']),
      categoria: json['categoria'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaInicio': fechaInicio?.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'categoria': categoria,
    };
  }
}
