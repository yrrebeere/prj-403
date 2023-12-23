import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/Classes/user_tables.dart';

void main() => runApp(VendorApp());

class VendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  TextEditingController userIdController = TextEditingController();
  List<UserTables> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/api/user_table/allusers'));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      setState(() {
        _users = jsonList.map((item) => UserTables.fromJson(item)).toList();
      });
    } else {
      print('Failed to load users');
    }
  }

  Future<void> _fetchUserById() async {
    TextEditingController idController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fetch User by ID'),
          content: Column(
            children: [
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter User ID'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _fetchUser(int.parse(idController.text));
              },
              child: Text('Fetch'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchUser(int userId) async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:3000/api/user_table/$userId'));

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      setState(() {
        _users = [UserTables.fromJson(json)];
      });
    } else {
      print('Failed to load user by ID');
    }
  }

  Future<void> _addUser() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController languageController = TextEditingController();
    TextEditingController userTypeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New User'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: languageController,
                decoration: InputDecoration(labelText: 'Language'),
              ),
              TextField(
                controller: userTypeController,
                decoration: InputDecoration(labelText: 'User Type'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _createUser(
                  nameController.text,
                  usernameController.text,
                  phoneNumberController.text,
                  languageController.text,
                  userTypeController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createUser(String name, String username, String phoneNumber,
      String language, String userType) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/user_table/addUser'),
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
      await _fetchUsers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User successfully added!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<void> _updateUser(int userId) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController languageController = TextEditingController();
    TextEditingController userTypeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update User'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              TextField(
                controller: languageController,
                decoration: InputDecoration(labelText: 'Language'),
              ),
              TextField(
                controller: userTypeController,
                decoration: InputDecoration(labelText: 'User Type'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _performUpdate(
                  userId,
                  nameController.text,
                  usernameController.text,
                  phoneNumberController.text,
                  languageController.text,
                  userTypeController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _performUpdate(
    int userId,
    String name,
    String username,
    String phoneNumber,
    String language,
    String userType,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/api/user_table/$userId'),
        body: jsonEncode({
          'name': name,
          'username': username,
          'phone_number': phoneNumber,
          'language': language,
          'user_type': userType,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await _fetchUsers();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User successfully updated!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update user. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error updating user: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showUpdateUserDialog() async {
    TextEditingController idController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update User by ID'),
          content: Column(
            children: [
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter User ID'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _updateUser(int.parse(idController.text));
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUserConfirmation(BuildContext context, int userId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure you want to delete this user?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteUser(userId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteUser(int userId) async {
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:3000/api/user_table/$userId'),
    );

    if (response.statusCode == 200) {
      await _fetchUsers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User successfully deleted!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete user. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

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
          ElevatedButton(
            onPressed: () {
              _showUpdateUserDialog();
            },
            child: Text('Update User'),
          ),
          ElevatedButton(
            onPressed: () => _addUser(),
            child: Text('Add User'),
          ),
          if (_users.isNotEmpty)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _fetchUsers();
                },
                child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_users[index].name),
                      subtitle: Text(_users[index].username),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await _deleteUserConfirmation(
                              context, _users[index].userId);
                        },
                        child: Text('Delete User'),
                      ),
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
