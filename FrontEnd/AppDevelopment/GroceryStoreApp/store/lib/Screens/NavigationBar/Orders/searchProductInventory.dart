import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'currentorders.dart';
import 'orderhistory.dart';

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

  // Hardcoded vendorId as 1
  int vendorId = 1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to the page for current orders
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrentOrdersPage(vendorId),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceOut, // Use bounceOut curve for bounce effect
                decoration: BoxDecoration(
                  color: Color(0xFF6FB457),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            AppLocalizations.of(context)!.curr_orders,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to the page for order history
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistory(vendorId),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.bounceOut, // Use bounceOut curve for bounce effect
                decoration: BoxDecoration(
                  color: Color(0xFF6FB457),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            AppLocalizations.of(context)!.order_history,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
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
