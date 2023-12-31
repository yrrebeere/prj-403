import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';
import 'dart:convert';

class searchProductInventory {
  final int productId;
  final String name;
  final String imageUrl;


  searchProductInventory({
    required this.productId,
    required this.name,
    required this.imageUrl,

  });

  factory searchProductInventory.fromJson(Map<String, dynamic> json) {
    return searchProductInventory(
      productId: json['product_id'],
      name: json['product_name'],
      imageUrl: json['image'],
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<searchProductInventory> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xfff2f2f6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search My Inventory",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    String query = searchController.text;
                    await _searchProductById(query);
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            // onTap: () {
            //   // Ensure that you're using the context from the Navigator widget
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => Order(),
            //     ),
            //   );
            // },
            child: Container(
              height: 160,
              width: 380,
              decoration: BoxDecoration(
                  color: Color(0xFF141022),
                borderRadius: BorderRadius.circular(20),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('You have',style: TextStyle(color: Colors.white, fontSize: 18),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('15',style: TextStyle(color: Colors.white, fontSize: 30),),
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ],
                      ),
                      Row(
                      children: [
                        Text('Total Orders today',style: TextStyle(color: Colors.white, fontSize: 18),),
                      ],
                    ),
                    ],
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _searchProductById(String query) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/api/search/$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        searchResults = data.map((item) => searchProductInventory.fromJson(item)).toList();
      });
    } else {
      print('Failed to load products');
    }
  }

}
