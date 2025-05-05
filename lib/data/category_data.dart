class CategoryData {
  final int id; 
  final String name;
  final String imageUrl;

  const CategoryData({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

 List<CategoryData> categories = [
  const CategoryData(id: 3, name: 'Montaña', imageUrl: 'assets/images/category_images/mountain.jpg'),
  const CategoryData(id: 2, name: 'Ciudad', imageUrl: 'assets/images/category_images/ciudad.jpg'),
  const CategoryData(id: 4, name: 'Playa', imageUrl: 'assets/images/category_images/playa.jpg'),
  const CategoryData(id: 6, name: 'camping', imageUrl: 'assets/images/category_images/crucero.jpg'),
  const CategoryData(id: 5, name: 'Avion', imageUrl: 'assets/images/category_images/safari.jpg'),
];
