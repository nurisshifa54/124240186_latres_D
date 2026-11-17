class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String brand;
  final String thumbnail;
  final double price;
  final double rating;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.brand,
    required this.thumbnail,
    required this.price,
    required this.rating,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> jsonData) {
    return Product(
      id: jsonData['id'],
      title: jsonData['title'] ?? '',
      description: jsonData['description'] ?? '',
      category: jsonData['category'] ?? '',
      brand: jsonData['brand'] ?? '-',
      thumbnail: jsonData['thumbnail'] ?? '',
      price: (jsonData['price'] ?? 0).toDouble(),
      rating: (jsonData['rating'] ?? 0).toDouble(),
      stock: jsonData['stock'] ?? 0,
    );
  }
}
