import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
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
    print("hi");
    print(response.body);


    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      setState(() {
        _groceryStoreList =
            jsonList.map((item) => Store.fromJson(item)).toList();
      });
    } else {
      print('Failed to load grocery store');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var store in _groceryStoreList)
            Container(
              height: 350,
              width: 370,
              margin: const EdgeInsets.symmetric(vertical: 10),
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
                child: Column(
                  children: [
                    Row(
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
                                ),
                               child:  Image.asset(
                                 store.image,
                                 fit: BoxFit.cover,
                               ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text(store.storeName)),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                ' ${store.storeAddress}',
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('Items', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('Bread', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('Bread', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('Bread', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('Quantity', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('x3', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('x12', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('x2', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('Price', style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('PKR 520', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('PKR 200', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(
                                    child: Text('PKR 238', style: TextStyle(fontSize: 15, color: Colors.black),)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Total Bill:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('PKR 958'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
