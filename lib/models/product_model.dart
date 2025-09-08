class Product {
  final int productId;
  final String name;
  final String category;
  final double price;
  final Map<String, dynamic> details;
  final Map<String, dynamic> shop;
  final String shopName;

  Product({
    required this.productId,
    required this.name,
    required this.category,
    required this.price,
    required this.details,
    required this.shop,
    required this.shopName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final shopMap = json['shop'] ?? {};
    final shopName = shopMap['shopname'] ?? '';
    return Product(
      productId: json['productId'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      details: json['details'] ?? {},
      shop: shopMap,
      shopName: shopName,
    );
  }
}
