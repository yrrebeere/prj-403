import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/Classes/user_tables.dart';

void main() => runApp(VendorApp());

class VendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: UsersScreen(),
    );
  }
}

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UserTables> _users = [];
  int userId = 2;

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Fetch all users initially
  }

  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/user_table/allusers'));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      setState(() {
        _users = jsonList.map((item) => UserTables.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> _fetchUserById() async {
    TextEditingController userIdController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter User ID'),
          content: TextField(
            controller: userIdController,
            keyboardType: TextInputType.number,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(userIdController.text);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    ).then((input) {
      if (input != null && input.isNotEmpty) {
        int id = int.parse(input);
        _fetchUser(id);
      }
    });
  }

  Future<void> _fetchUser(int id) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/user_table/$id'));

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      setState(() {
        _users = [UserTables.fromJson(json)];
      });
    } else {
      throw Exception('Failed to load user');
    }
  }

  // Future<void> _addUser() async {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController usernameController = TextEditingController();
  //   TextEditingController phoneNumberController = TextEditingController();
  //   TextEditingController languageController = TextEditingController();
  //   TextEditingController userTypeController = TextEditingController();
  //
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Add New User'),
  //         content: Column(
  //           children: [
  //             TextField(
  //               controller: nameController,
  //               decoration: InputDecoration(labelText: 'Name'),
  //             ),
  //             TextField(
  //               controller: usernameController,
  //               decoration: InputDecoration(labelText: 'Username'),
  //             ),
  //             TextField(
  //               controller: phoneNumberController,
  //               decoration: InputDecoration(labelText: 'Phone Number'),
  //               keyboardType: TextInputType.phone,
  //             ),
  //             TextField(
  //               controller: languageController,
  //               decoration: InputDecoration(labelText: 'Language'),
  //             ),
  //             TextField(
  //               controller: userTypeController,
  //               decoration: InputDecoration(labelText: 'User Type'),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               _createUser(
  //                 nameController.text,
  //                 usernameController.text,
  //                 phoneNumberController.text,
  //                 languageController.text,
  //                 userTypeController.text,
  //               );
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Add'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //
  // Future<void> _createUser(
  //     String name,
  //     String username,
  //     String phoneNumber,
  //     String language,
  //     String userType,
  //     ) async {
  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:3000/api/user_table/adduser'),
  //     body: jsonEncode({
  //       'name': name,
  //       'username': username,
  //       'phone_number': phoneNumber,
  //       'language': language,
  //       'user_type': userType,
  //     }),
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 201) {
  //     // User added successfully, fetch all users again
  //     await _fetchUsers();
  //   } else {
  //     throw Exception('Failed to add user');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _fetchUsers(),
            child: Text('Fetch All Users'),
          ),
          ElevatedButton(
            onPressed: () => _fetchUserById(),
            child: Text('Fetch User by ID'),
          ),
          // ElevatedButton(
          //   onPressed: () => _addUser(),
          //   child: Text('Add User'),
          // ),
          if (_users.isNotEmpty)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _fetchUsers();
                },
                child: ListView.separated(
                  itemCount: _users.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_users[index].name),
                      subtitle: Text(_users[index].username),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
