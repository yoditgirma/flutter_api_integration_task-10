class Product {
  final int id;
  final String image, title, description, category;
  final double price;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      image: json['image'],
      title: json['title'] ?? 'Unknown',
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
    };
  }
}
