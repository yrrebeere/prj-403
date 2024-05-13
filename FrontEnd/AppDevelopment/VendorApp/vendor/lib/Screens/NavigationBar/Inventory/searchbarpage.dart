import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Screens/NavigationBar/Inventory/productdetailspage.dart';
import '../../../Classes/inventory_item.dart';
import '../../../Classes/product_inventory.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';
import 'itemdetails.dart';

class SearchBarPage extends StatefulWidget {
  final List<productInventory> productInventories;

  SearchBarPage({required this.productInventories});

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<InventoryItem> suggestions = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
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
              key: _scaffoldKey, // Assign the key to the scaffold
              appBar: AppBar(
                title: Text(AppLocalizations.of(context)!.search_page),
                backgroundColor: Color(0xFFFF9100),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ),
              body: Column(
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
                            String query = searchController.text;
                            await _fetchAndDisplayProducts(query);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        final product = suggestions[index];

                        final imageUrl = product.imageUrl;

                        return GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  product: product,
                                  addToInventoryCallback: _addToInventory,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 105,
                            margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            child: Center(
                              child: ListTile(
                                title: Text(product.name),
                                leading: Image.network(
                                  "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/" + imageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context, Object error,
                                      StackTrace? stackTrace) {
                                    return Icon(Icons.error);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _fetchAndDisplayProducts(String query) async {
    final response = await http.get(
      Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/searchproduct/$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        suggestions = data.map((item) => InventoryItem.fromJson(item)).toList();
      });
    } else {
      print('Failed to load products');
    }
  }

  Future<void> _addToInventory(String listedAmount, String availableAmount, String price, int vendorId, int productProductId) async {
    bool isDuplicate = widget.productInventories.any((product) => product.productProductId == productProductId);

    Future<void> _showDuplicateProductAlert(int duplicateProductId) async {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product already in inventory'),
          duration: Duration(seconds: 2),
        ),
      );

      // Find the duplicate product in the productInventories list
      productInventory duplicateProduct = widget.productInventories.firstWhere(
            (product) => product.productProductId == duplicateProductId,
        orElse: () => productInventory(
          productInventoryId: -1,
          price: -1,
          availableAmount: -1,
          listedAmount: -1,
          vendorVendorId: -1,
          productProductId: -1,
        ),
      );

      // Open the details page for the duplicate product
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemDetailsPage(
              item: duplicateProduct,
              onDelete: () {},
              onDeleted: () {},
              onUpdate: () {}
          ),
        ),
      );
    }

    if (isDuplicate) {
      print('Product is a duplicate');
      _showDuplicateProductAlert(productProductId);
    }

    else {
      final response = await http.post(
        Uri.parse(
            'https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_inventory/addproductinventory'),
        body: jsonEncode({
          'listed_amount': listedAmount,
          'available_amount': availableAmount,
          'price': price,
          'vendor_vendor_id': vendorId,
          'product_product_id': productProductId
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Product added to inventory successfully');
      } else {
        print('Failed to add product to inventory');
      }
    }
  }

}