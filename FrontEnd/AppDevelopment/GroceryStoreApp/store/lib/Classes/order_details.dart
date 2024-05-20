class OrderDetails {
  int? detailId;
  int quantity;
  int unitPrice;
  int totalPrice;
  int orderId;
  int productInventoryId;

  OrderDetails({
    this.detailId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.orderId,
    required this.productInventoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'order_order_id': orderId,
      'product_inventory_product_inventory_id': productInventoryId,
    };
  }
}