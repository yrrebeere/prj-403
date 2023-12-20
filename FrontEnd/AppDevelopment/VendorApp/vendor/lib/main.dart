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
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }
  Future<void> _fetchUsers() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/user_table/allusers'));
    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      setState(() {
        _users = json.map((item) => UserTables.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load users');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_users[index].name),
            subtitle: Text(_users[index].username),
          );
        },
      ),
    );
  }
}