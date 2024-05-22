class Product {
  final int productId;
  final String productName;
  final String image;
  final int productNumber;

  Product({
    required this.productId,
    required this.productName,
    required this.image,
    required this.productNumber,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      image: json['image'],
      productNumber: json['product_number'],
    );
  }
}