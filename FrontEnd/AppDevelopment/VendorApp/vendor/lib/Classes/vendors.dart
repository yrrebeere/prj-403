class Vendors {
  final int vendorId;
  final String vendorName;
  final String deliveryLocations;
  final int userId;
  final String image;

  Vendors({
    required this.vendorId,
    required this.vendorName,
    required this.deliveryLocations,
    required this.userId,
    required this.image,
  });

  factory Vendors.fromJson(Map<String, dynamic> json) {
    return Vendors(
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      deliveryLocations: json['delivery_locations'],
      userId: json['user_table_user_id'],
      image: json['image'],
    );
  }
}