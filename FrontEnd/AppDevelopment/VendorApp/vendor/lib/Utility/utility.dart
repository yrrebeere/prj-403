import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> createUser(String name, String username, String phoneNumber, String language, String userType) async {

  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/user_table/adduser'),
    body: jsonEncode({
      'name': name,
      'username': username,
      'phone_number': phoneNumber,
      'language': language,
      'user_type': userType,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 201) {
    print("User added");
    final dynamic json = jsonDecode(response.body);
    createVendor(name, 'Dha', json['user_id']);
  }
  else {
    throw Exception('Failed to add user');
  }

}

Future<void> createVendor(String vendorName, String deliveryLocations, int userId) async {

  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/vendor/addvendor'),
    body: jsonEncode({
      'vendor_name': vendorName,
      'delivery_locations': deliveryLocations,
      'user_table_user_id': userId,
    }),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 201) {
    print("Vendor added");
  }
  else {
    throw Exception('Failed to add user');
  }

}

