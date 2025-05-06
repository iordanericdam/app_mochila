class CategoryData {
  final int id;
  final String name;
  final String imageUrl;

  const CategoryData({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}