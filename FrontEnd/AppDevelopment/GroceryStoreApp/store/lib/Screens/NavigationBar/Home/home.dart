import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../SelectLanguage/languageprovider.dart';
// import 'orderhistory.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class SearchProductInventory {
  final int productId;
  final String name;
  final String imageUrl;

  SearchProductInventory({
    required this.productId,
    required this.name,
    required this.imageUrl,
  });

  factory SearchProductInventory.fromJson(Map<String, dynamic> json) {
    return SearchProductInventory(
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
  List<SearchProductInventory> searchResults = [];
  TextEditingController searchController = TextEditingController();

  int vendorId = 1;
  int numberOfCurrentOrders = 4;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        print("Selected Locale: ${languageProvider.selectedLocale}");

        return MaterialApp(
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
            body: Container(
              child: SingleChildScrollView(
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
                                hintText: AppLocalizations.of(context)!.search,
                              ),
                            ),
                          ),

                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () async {
                              String productName = searchController.text;
                              print('Searching for product: $productName'); // Add this debug print
                              await _searchProductInInventory(productName);
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
                          // You can customize the display further based on your needs
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
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      AppLocalizations.of(context)!.you_have,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '$numberOfCurrentOrders',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 30),
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        color: Colors.white),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .orders_today,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => OrderHistoryPage(vendorId),
                      //     ),
                      //   );
                      // },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        height: 90,
                        width: 380,
                        decoration: BoxDecoration(
                          color: Color(0xFF6FB457),
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
                                          Icons.history,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .order_history,
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
        );
      },
    );
  }

// Modify the _searchProductInInventory method
  Future<void> _searchProductInInventory(String productName) async {
    try {
      print('Searching for product: $productName'); // Add this debug print
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/product/searchproductininventory/$vendorId/$productName'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print('Search results: $data'); // Debug print

        // Displaying the name and image for each result
        for (var item in data) {
          print('Name: ${item['product_name']}, Image: ${item['image']}');
        }

        setState(() {
          searchResults = data.map((item) => SearchProductInventory.fromJson(item)).toList();
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