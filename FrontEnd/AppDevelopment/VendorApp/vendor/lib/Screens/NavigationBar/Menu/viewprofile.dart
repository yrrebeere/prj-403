import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  @override
  void initState() {
    super.initState();
    name = "";
    number = "";
    username = "";
    language = "";
    fetchUserProfile(widget.userId);
  }

  Future<void> fetchUserProfile(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('http://10.0.2.2:3000/api/user_table/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          name = data['name'];
          number = data['phone_number'].toString().trim();
          username = data['username'].toString().trim();
          language = data['language'].toString().trim();
        });
      } else {
        print(
            'Failed to fetch user information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error during HTTP request: $error');
    }
  }

  Future<void> updateUserName(String newName) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/api/user_table/${widget.userId}'),
        body: {'name': newName},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Name updated successfully'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update name. Status code: ${response.statusCode}'),
          ),
        );
      }
    } catch (error) {
      print('Error during HTTP request: $error');
    }
  }

  Future<void> showEditDialog() async {
    String editedName = name;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$name'),
              TextField(
                onChanged: (value) {
                  editedName = value;
                },
                decoration: InputDecoration(labelText: 'New Name'),
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
              onPressed: () {
                updateUserName(editedName);
                Navigator.pop(context);
                setState(() {
                  name = editedName;
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
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
                    color: Color(0xFF6FB457),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildProfileInfo("Name", name),
              SizedBox(height: 20),
              _buildProfileInfo("Username", username),
              SizedBox(height: 20),
              _buildProfileInfo("Phone Number", number),
              SizedBox(height: 20),
              _buildProfileInfo("Language", language),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showEditDialog();
                },
                child: Text(AppLocalizations.of(context)!.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
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
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: label == "Name" ? null : Colors.grey),
          ),
        ],
      ),
    );
  }
}
