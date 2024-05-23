import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Classes/user_provider.dart';
import 'currentorders.dart';
import 'package:provider/provider.dart';

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

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<searchProductInventory> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Accessing the vendorId from the provider
    String vendorId = Provider.of<UserProvider>(context).vendorId;

    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to the page for current orders
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrentOrdersPage(int.parse(vendorId)),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                height: 120,
                width: 380,
                decoration: BoxDecoration(
                  color:  Color(0xFFFF9100),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  AppLocalizations.of(context)!
                                      .curr_orders,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            // Moved the arrow icon here
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                          ],
                        ),
                      ),
                      // Add other content for the Current Orders tile as needed
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
