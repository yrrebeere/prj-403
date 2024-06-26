import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../../Classes/api.dart';
import '../../../Classes/user_provider.dart';

class ViewProfile extends StatefulWidget {
  final String userId;

  ViewProfile({required this.userId});

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  late String name;
  late String number;
  late String username;
  late String language;
  late String image;
  late String vendorId;

  @override
  void initState() {
    super.initState();
    name = "";
    number = "";
    username = "";
    language = "";
    image = "";
    fetchUserProfile(widget.userId);
    fetchVendorProfile();
  }

  Future<void> fetchVendorProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    vendorId = userProvider.vendorId.toString();

    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/vendor/$vendorId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        setState(() {
          image = data['image'].toString().trim();
        });
      } else {
        print('Failed to fetch vendor information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during HTTP request: $error');
    }
  }

  Future<void> fetchUserProfile(String userId) async {
    try {
      final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/user_table/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          name = data['name'];
          number = data['phone_number'].toString().trim();
          username = data['username'].toString().trim();
          language = data['language'].toString().trim();
        });
      } else {
        print('Failed to fetch user information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during HTTP request: $error');
    }
  }

  Future<void> updateField(String field, String value) async {
    try {
      if (field == 'password') {
        if (!_isPasswordValid(value)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid password. Password must be at least 8 characters long and contain at least one special character')));
          return;
        }
      }

      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/api/user_table/${widget.userId}'),
        body: {field: value},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${field} updated successfully'),
          ),
        );
        setState(() {
          if (field == 'name') {
            name = value;
          } else if (field == 'username') {
            username = value;
          } else if (field == 'phone_number') {
            number = value;
          } else if (field == 'language') {
            language = value;
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update ${field.toLowerCase()}. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      print('Error during HTTP request: $error');
    }
  }


  Future<bool> isUsernameAvailable(String username) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/user_table/usernameexists/$username'));
    print(username+response.body);
    return response.statusCode == 200 && json.decode(response.body) == false;
  }

  Future<bool> isPhoneNumberAvailable(String phoneNumber) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/user_table/numberExists/$phoneNumber'));
    print(json.decode(response.body)['exists']);
    return response.statusCode == 200 && json.decode(response.body)['exists'] == false;
  }

  Future<void> showEditDialog(String field, String currentValue) async {
    String editedValue = currentValue;
    bool isPasswordValid = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (field == 'password') // Handle password field
                TextField(
                  obscureText: true,
                  onChanged: (value) {
                    editedValue = value;
                    // Check password validation
                    isPasswordValid = _isPasswordValid(editedValue);
                  },
                  decoration: InputDecoration(labelText: 'New Password'),
                )
              else // For other fields
                TextField(
                  controller: TextEditingController(text: editedValue),
                  onChanged: (value) {
                    editedValue = value;
                  },
                  decoration: InputDecoration(labelText: 'New $field'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (field == 'username') {
                  final isUsernameValid = await isUsernameAvailable(editedValue);
                  if (!isUsernameValid) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Username already exists')));
                    return;
                  }
                } else if (field == 'phone_number') {
                  final isPhoneNumberValid = await isPhoneNumberAvailable(editedValue);
                  if (!isPhoneNumberValid) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Phone number already exists')));
                    return;
                  }
                } else if (field == 'password') {
                  if (!isPasswordValid) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid password. Password must be at least 8 characters long and contain at least one special character')));
                    return;
                  }
                }

                updateField(field, editedValue);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  bool _isPasswordValid(String password) {
    // Validate password: at least 8 characters long and contains at least one special character
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // Helper function to capitalize the first letter of a string
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9100),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(
            AppLocalizations.of(context)!.app_name,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child:
                    Image.network(
                      '${ApiConstants.baseUrl}/api/image/' + image,
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildProfileInfo("Name", name, () {
                showEditDialog('name', name);
              }),
              SizedBox(height: 20),
              _buildProfileInfo("Username", username, () {
                showEditDialog('username', username);
              }),
              SizedBox(height: 20),
              _buildProfileInfo("Phone Number", number, () {
                showEditDialog('phone_number', number);
              }),
              SizedBox(height: 20),
              _buildProfileInfo("Language", language, () {
                showEditDialog('language', language);
              }),
              _buildProfileInfo("Password", "*********", () {
                showEditDialog('password', ''); // Initialize with empty password
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$label: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF9100),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value.isNotEmpty ? value : 'Not provided',
            style: TextStyle(fontSize: 18, color: label == "Name" ? null : Colors.grey),
          ),
        ],
      ),
    );
  }
}
