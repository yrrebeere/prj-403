class Stores {
  final int storeId;
  final String storeName;
  final String storeAddress;
  final int userId;

  Stores({
    required this.storeId,
    required this.storeName,
    required this.storeAddress,
    required this.userId,
  });

  factory Stores.fromJson(Map<String, dynamic> json) {
    return Stores(
      storeId: json['store_id'],
      storeName: json['store_name'],
      storeAddress: json['store_address'],
      userId: json['user_table_user_id'],
    );
  }
}