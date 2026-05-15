class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final String emoji;
  final String? imagePath;   // ex: 'assets/images/smash_classico.png'
  final bool isPopular;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.emoji,
    this.imagePath,
    this.isPopular = false,
  });
}
