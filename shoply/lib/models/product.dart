class Category {
  final String name;
  final String image;
  const Category(this.name, this.image);
}

class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final List<String> images;
  final bool isTrending;
  final double rating;
  final int reviews;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.images,
    this.isTrending = false,
    this.rating = 4.5,
    this.reviews = 120,
  });

  String get thumb => images.first;
}
