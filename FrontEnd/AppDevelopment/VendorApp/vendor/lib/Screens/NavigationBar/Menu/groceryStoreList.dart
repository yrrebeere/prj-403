import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(
  MyApp(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Storelist(),
    );
  }
}

class Store {
  final String storeName;
  final String image;
  final String storeAddress;

  Store({
    required this.storeName,
    required this.image,
    required this.storeAddress,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeName: json['store_name'],
      image: json['image'],
      storeAddress: json['store_address'],
    );
  }
}

class Storelist extends StatefulWidget {
  const Storelist({super.key});

  @override
  State<Storelist> createState() => _StorelistState();
}



class _StorelistState extends State<Storelist> {
  List<Store> _groceryStoreList = [];
  int vendorId = 1;

  @override
  void initState() {
    super.initState();
    _fetchGroceryStoresList();
  }

  Future<void> _fetchGroceryStoresList() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/api/grocery_store/searchstore/$vendorId'),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      setState(() {
        _groceryStoreList = jsonList.map((item) => Store.fromJson(item)).toList();
      });
    } else {
      print('Failed to load grocery store');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _groceryStoreList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Store Name: ${_groceryStoreList[index].storeName}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


