import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Screens/NavigationBar/Inventory/searchbarpage.dart';
import '../../../Classes/inventory_item.dart';
import '../../../Classes/product_inventory.dart';
import 'package:flutter/services.dart';
import 'itemdetails.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() => runApp(InventoryApp());

class InventoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Inventory(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
      navigatorObservers: [routeObserver],
    );
  }
}

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> with RouteAware {
  List<productInventory> productInventories = [];
  final List<productInventory> inventoryItems = [];
  List<InventoryItem> suggestions = [];

  @override
  void didPopNext() {
    _fetchAndDisplayCombinedData("7"); // Refresh data when returning to this page
  }

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayProductInventories("7");
    _fetchAndDisplayCombinedData("7");
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      if (route != null) {
        routeObserver.subscribe(this, route as PageRoute<dynamic>);
      }
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<void> _fetchAndDisplayCombinedData(String vendorId) async {
    final response = await http.get(
      Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_inventory/search/$vendorId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<productInventory> tempProductInventories = [];
      List<InventoryItem> tempSuggestions = [];

      for (final item in data) {
        final productInventoryItem = productInventory.fromJson(item as Map<String, dynamic>);

        final productId = productInventoryItem.productProductId;
        final productInventoryResponse = await http.get(
          Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/$productId'),
        );

        if (productInventoryResponse.statusCode == 200) {
          final Map<String, dynamic> productInventoryData = jsonDecode(productInventoryResponse.body);

          final String productName = productInventoryData['product_name'];
          final String imageUrl = productInventoryData['image'];

          final combinedProduct = InventoryItem(
            productId: productId,
            name: productName,
            imageUrl: imageUrl,
          );

          final combinedProductInventory = productInventory(
            productInventoryId: productInventoryItem.productInventoryId,
            price: productInventoryItem.price,
            availableAmount: productInventoryItem.availableAmount,
            listedAmount: productInventoryItem.listedAmount,
            vendorVendorId: productInventoryItem.vendorVendorId,
            productProductId: productInventoryItem.productProductId,
          );

          tempProductInventories.add(combinedProductInventory);
          tempSuggestions.add(combinedProduct);
        } else {
          print('Failed to load additional product information');
        }
      }

      setState(() {
        // Update your state with the combined data
        productInventories = tempProductInventories;
        suggestions = tempSuggestions;
      });
    } else {
      print('Failed to load products');
    }
  }

  Future<void> _fetchAndDisplayProductInventories(String vendorId) async {
    final response = await http.get(
      Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_inventory/search/$vendorId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        print(response.body);
        productInventories =
            data.map((item) => productInventory.fromJson(item)).toList();
      });
    } else {
      print('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xfff2f2f6),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            '${productInventories.length} ${AppLocalizations.of(context)!.listed_sku}',
                            style: TextStyle(fontSize: 21),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: productInventories.length,
                      itemBuilder: (context, index) {
                        productInventory item = productInventories[index];

                        // Find the corresponding InventoryItem using productProductId
                        InventoryItem productItem = suggestions.firstWhere(
                              (inventoryItem) => inventoryItem.productId == item.productProductId,
                          orElse: () => InventoryItem(productId: -1, name: '', imageUrl: ''),
                        );

                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _openItemDetails(item);
                              },
                              child: Container(
                                width: 370, // Maintain fixed width
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
                                    crossAxisAlignment: CrossAxisAlignment.center, // Align children to the center vertically
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: Image.network(
                                              "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+productItem.imageUrl,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                                return Icon(Icons.error);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10), // Add spacing between image and text
                                      Expanded( // Use Expanded to allow the text to take available space
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${productItem.name}",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                                              maxLines: 2, // Limit to 2 lines
                                              overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                            ),
                                            Text(
                                              "${AppLocalizations.of(context)!.listed_amount}: ${item.listedAmount}",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue),
                                            ),
                                            Text(
                                              "${AppLocalizations.of(context)!.available_amount}: ${item.availableAmount}",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.blue),
                                            ),
                                            Text(
                                              "${AppLocalizations.of(context)!.price}: ${item.price}",
                                              textDirection: TextDirection.ltr,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color:Color(0xFF6FB457)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Wrap the content of the arrow in Align widget to center it vertically
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchBarPage(productInventories: productInventories,)),
          );

          if (result != null && result) {
            _fetchAndDisplayCombinedData("7"); // Refresh the data if result indicates a change
          }
        },
        backgroundColor:  Color(0xFFFF9100),
        child: Icon(Icons.add),
      ),
    );
  }

  void _openItemDetails(productInventory item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailsPage(
          item: item,
          onDelete: () {
            setState(() {
              inventoryItems.remove(item);
            });
          },
          onDeleted: () {
            setState(() {
              _fetchAndDisplayCombinedData("7");
            });
          },
          onUpdate: () {
            setState(() {
              _fetchAndDisplayCombinedData("7");
            });
          },
        ),
      ),
    );
  }
}
