class InventoryItem {
  final int productId;
  final String name;
  final String imageUrl;

  InventoryItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      productId: json['product_id'],
      name: json['product_name'],
      imageUrl: json['image'],
    );
  }
}