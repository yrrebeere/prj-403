class Vendor {
  final int vendorId;
  final String vendorName;
  final String vendorImage;
  final String vendorAddress;

  Vendor(
      {required this.vendorId,
        required this.vendorName,
        required this.vendorImage,
        required this.vendorAddress});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      vendorImage: json['image'],
      vendorAddress: json['delivery_locations'],
    );
  }
}