import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/Classes/user_tables.dart';

void main() => runApp(
    VendorApp()
);

class VendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UsersScreen(),
      // home: ,
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
        .get(Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/allusers'));
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
        .get(Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/$userId'));

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
    String selectedLanguage = 'English';
    String selectedUserType = 'Vendor';

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
              Row(
                children: [
                  Text('User Type: '),
                  DropdownButton<String>(
                    value: selectedUserType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUserType = newValue!;
                      });
                    },
                    items: <String>['Vendor', 'Grocery Store', 'Admin']
                        .map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    hint: Text('Select User Type'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Language: '),
                  DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLanguage = newValue!;
                      });
                    },
                    items: <String>['English', 'Urdu'].map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    hint: Text('Select Language'),
                  ),
                ],
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
                  selectedLanguage,
                  selectedUserType,
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
      Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/adduser'),
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
    String selectedUserType = 'Vendor';

    // Fetch existing user details
    UserTables existingUser = await _fetchUserDetails(userId);

    // Set default values for the text controllers
    nameController.text = existingUser.name;
    usernameController.text = existingUser.username;
    phoneNumberController.text = existingUser.phoneNumber.toString();
    languageController.text = existingUser.language;
    selectedUserType = existingUser.userType;

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
              Row(
                children: [
                  Text('Language: '),
                  DropdownButton<String>(
                    value: languageController.text, // Set existing value
                    onChanged: (String? newValue) {
                      setState(() {
                        languageController.text = newValue!;
                      });
                    },
                    items: <String>['English', 'Urdu'].map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    hint: Text('Select Language'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('User Type: '),
                  DropdownButton<String>(
                    value: selectedUserType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUserType = newValue!;
                      });
                    },
                    items: <String>['Vendor', 'Grocery Store', 'Admin']
                        .map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    hint: Text('Select User Type'),
                  ),
                ],
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
                  selectedUserType,
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


  Future<UserTables> _fetchUserDetails(int userId) async {
    final response = await http.get(
      Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/$userId'),
    );

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      return UserTables.fromJson(json);
    } else {
      print('Failed to load user details by ID');
      throw Exception('Failed to load user details by ID');
    }
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
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/$userId'),
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
      Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/$userId'),
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
                      // trailing: ElevatedButton(
                      //   onPressed: () async {
                      //     await _deleteUserConfirmation(
                      //         context, _users[index].userId);
                      //   },
                      //   child: Text('Delete User'),
                      // ),
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
