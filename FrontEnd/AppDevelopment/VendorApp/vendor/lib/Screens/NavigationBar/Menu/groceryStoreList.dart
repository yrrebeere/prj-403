import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vendor/Screens/NavigationBar/Menu/storeDetails.dart';

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

  @override
  void initState() {
    super.initState();
    _fetchAllGroceryStores();
  }

  Future<void> _fetchAllGroceryStores() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.2:3000/api/grocery_store/allstores'),
    );
    
    print('fizza');

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
          ElevatedButton(
            onPressed: () => _fetchAllGroceryStores(),
            child: Text('Fetch All Grocery Stores'),
          ),
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


