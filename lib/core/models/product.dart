class Product {
  final int id;
  final String name;
  final String? description;
  final double price;

  const Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String?,
        price: double.parse(json['price'].toString()),
      );
}
