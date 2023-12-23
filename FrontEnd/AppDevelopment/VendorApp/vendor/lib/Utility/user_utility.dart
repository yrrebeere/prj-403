import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String name;
  final String username;
  final String phoneNumber;
  final String language;
  final String userType;

  User({
    required this.name,
    required this.username,
    required this.phoneNumber,
    required this.language,
    required this.userType,
  });
}

class Vendor extends User {
  final String vendorName;
  final String deliveryLocation;

  Vendor({
    required String name,
    required String username,
    required String phoneNumber,
    required String language,
    required String userType,
    required this.vendorName,
    required this.deliveryLocation,
  }) : super(
    name: name,
    username: username,
    phoneNumber: phoneNumber,
    language: language,
    userType: userType,
  );
}

class UserService {
  static Future<void> createUser(User user) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/user_table/adduser'),
      body: jsonEncode({
        'name': user.name,
        'username': user.username,
        'phone_number': user.phoneNumber,
        'language': user.language,
        'user_type': user.userType,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('User successfully added!');
    } else {
      throw Exception('Failed to add user');
    }
  }

  static Future<void> createVendor(Vendor vendor) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/vendor/addvendor'),
      body: jsonEncode({
        // 'name': vendor.name,
        // 'username': vendor.username,
        // 'phone_number': vendor.phoneNumber,
        // 'language': vendor.language,
        // 'user_type': vendor.userType,
        'vendor_name': vendor.vendorName,
        'delivery_location': vendor.deliveryLocation,
        'user_table_user_id' : '1',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print('Vendor successfully added!');
    } else {
      throw Exception('Failed to add vendor');
    }
  }
}
