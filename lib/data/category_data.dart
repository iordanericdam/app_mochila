class CategoryData {
  final String name; 
  final String imageUrl;

  const CategoryData({
    required this.name,
    required this.imageUrl,
  });
}

  List<CategoryData>  categories = [
        const CategoryData(
          name: 'Montaña',
          imageUrl: 'assets/images/category_images/mountain.jpg',
        ),
        const CategoryData(
          name: 'Ciudad',
          imageUrl: 'assets/images/category_images/ciudad.jpg',
        ),
        const CategoryData(
          name: 'Playa',
          imageUrl: 'assets/images/category_images/playa.jpg',
        ),
        const CategoryData(
          name: 'Crucero',
          imageUrl: 'assets/images/category_images/crucero.jpg',
        ),
        const CategoryData(
          name: 'Safari',
          imageUrl: 'assets/images/category_images/safari.jpg',
        ),
  ];
