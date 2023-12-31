import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:vendor/Screens/NavigationBar/Menu/storeDetails.dart';

class Store {
  final String storeName;
  final String image;
  final String storeAddress;

  Store({
    required this.storeName,
    required this.image,
    required this.storeAddress,
  });
}

class StoreList extends StatefulWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  List<Store> stores = [];

  @override
  void initState() {
    super.initState();
    // Fetch stores when the widget is initialized
    fetchStores();
  }

  void fetchStores() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:3000/api/grocery_store/allstores"),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        List<dynamic> data = json.decode(response.body);
        List<Store> fetchedStores =
        data.map((store) => Store(store['store_name'])).toList();

        setState(() {
          stores = fetchedStores;
        });
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception.
        throw Exception('Failed to load stores');
      }
    } catch (e) {
      print('Error fetching stores: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6FB457),
          title: Padding(
            padding: const EdgeInsets.only(left: 90),
            child: Text('WASAIL'),
          ),
          elevation: 0,
          leading: IconButton(
            icon: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Color(0xfff2f2f6),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Store List',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      // Use ListView.builder to dynamically build the store list
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: stores.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              buildStoreCard(stores[index]),
                              SizedBox(height: 20),
                              // Add some spacing between stores
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStoreCard(Store store) {
    return GestureDetector(
      onTap: () {
        // Navigate to StoreDetails page when the store card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreDetails(storeName: store.storeName),
          ),
        );
      },
      child: Container(
        height: 160,
        width: 370,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      store.storeName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
