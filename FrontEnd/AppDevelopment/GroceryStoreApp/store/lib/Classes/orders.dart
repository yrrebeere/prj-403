class Orders {
  int? orderId;
  DateTime orderDate;
  DateTime deliveryDate;
  int totalBill;
  String orderStatus;
  int groceryStoreId;
  int vendorId;

  Orders({
    this.orderId,
    required this.orderDate,
    required this.deliveryDate,
    required this.totalBill,
    required this.orderStatus,
    required this.groceryStoreId,
    required this.vendorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_date': orderDate.toIso8601String(),
      'delivery_date': deliveryDate.toIso8601String(),
      'total_bill': totalBill,
      'order_status': orderStatus,
      'grocery_store_store_id': groceryStoreId,
      'vendor_vendor_id': vendorId,
    };
  }
}