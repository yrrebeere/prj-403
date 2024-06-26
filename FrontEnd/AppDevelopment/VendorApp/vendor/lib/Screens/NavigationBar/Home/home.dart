import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../Classes/api.dart';
import '../../../Classes/inventory_item.dart';
import '../../../Classes/user_provider.dart';
import '../../../Classes/languageprovider.dart';
import '../navbar.dart';
import 'orderhistory.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<InventoryItem> searchResults = [];
  TextEditingController searchController = TextEditingController();
  int numberOfCurrentOrders = 0;

  @override
  void initState() {
    super.initState();
    // Fetch current orders after the widget is built to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCurrentOrders();
    });
  }

  Future<void> _fetchCurrentOrders() async {
    try {
      final vendorId = Provider.of<UserProvider>(context, listen: false).vendorId;
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/order/totalorders/$vendorId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          numberOfCurrentOrders = data['orders'];
        });
      } else {
        print('Failed to fetch order count');
        // Optionally, handle the error with a UI message
      }
    } catch (e) {
      print('Error: $e');
      // Optionally, handle the error with a UI message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider, UserProvider>(
      builder: (context, languageProvider, userProvider, child) {
        print("Selected Locale: ${languageProvider.selectedLocale}");
        final vendorId = userProvider.vendorId;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: languageProvider.selectedLocale,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: child!,
            );
          },
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
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
                                  hintText: AppLocalizations.of(context)!.search,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                String productName = searchController.text;
                                print('Searching for product: $productName');
                                await _searchProductInInventory(productName, vendorId);
                              },
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: searchResults
                            .map(
                              (product) => ListTile(
                            title: Text(product.name),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavBar(initialIndex: 2),
                                ),
                              );
                            },
                          ),
                        )
                            .toList(),
                      ),
                      GestureDetector(
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
                                    Text(
                                      AppLocalizations.of(context)!.you_have,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$numberOfCurrentOrders',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.orders_today,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderHistoryPage(),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: 90,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF9100),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.history,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .order_history,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios,
                                          color: Colors.white),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Modify the _searchProductInInventory method
  Future<void> _searchProductInInventory(String productName, String vendorId) async {
    try {
      print('Searching for product: $productName'); // Add this debug print
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/product/searchproductininventory/$vendorId/$productName'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Search results: $data'); // Debug print

        // Displaying the name and image for each result
        for (var item in data) {
          print('Name: ${item['product_name']}, Image: ${item['image']}');
        }

        setState(() {
          searchResults = data.map((item) => InventoryItem.fromJson(item)).toList();
        });
      } else {
        print('Failed to load products');
        // Show a snackbar with an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load products. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show a snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
