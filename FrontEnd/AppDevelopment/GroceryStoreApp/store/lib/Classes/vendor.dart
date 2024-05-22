class Vendor {
  final int vendorId;
  final String vendorName;
  final String image;
  final String deliveryLocations;
  final int userId;

  Vendor({
    required this.vendorId,
    required this.vendorName,
    required this.image,
    required this.deliveryLocations,
    required this.userId
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      image: json['image'],
      deliveryLocations: json['delivery_locations'],
      userId: json['user_table_user_id'],
    );
  }
}