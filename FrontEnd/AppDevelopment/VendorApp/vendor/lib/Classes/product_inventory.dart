class productInventory {
  final int productInventoryId;
  final int price;
  final int availableAmount;
  final int listedAmount;
  final int vendorVendorId;
  final int productProductId;

  productInventory({
    required this.productInventoryId,
    required this.price,
    required this.availableAmount,
    required this.listedAmount,
    required this.vendorVendorId,
    required this.productProductId,
  });

  factory productInventory.fromJson(Map<String, dynamic> json) {
    return productInventory(
      productInventoryId: json['product_inventory_id'],
      price: json['price'],
      availableAmount: json['available_amount'],
      listedAmount: json['listed_amount'],
      vendorVendorId: json['vendor_vendor_id'],
      productProductId: json['product_product_id'],
    );
  }
}