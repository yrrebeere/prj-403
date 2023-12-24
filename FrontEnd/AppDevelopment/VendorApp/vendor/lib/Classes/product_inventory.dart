class ProductInventory {
  final int productInventoryId;
  final int price;
  final int availableAmount;
  final int listedAmount;
  final int vendorId;
  final int productId;


  ProductInventory({
    required this.productInventoryId,
    required this.price,
    required this.availableAmount,
    required this.listedAmount,
    required this.vendorId,
    required this.productId,
  });

  factory ProductInventory.fromJson(Map<String, dynamic> json) {
    return ProductInventory(
      productInventoryId: json['product_inventory_id'],
      price: json['price'],
      availableAmount: json['available_amount'],
      listedAmount: json['listed_amount'],
      vendorId: json['vendor_vendor_id'],
      productId: json['product_product_id'],
    );
  }
}