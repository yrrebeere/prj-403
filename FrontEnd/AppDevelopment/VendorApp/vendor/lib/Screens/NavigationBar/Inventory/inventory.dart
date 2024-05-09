import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Screens/NavigationBar/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';

import 'itemdetails.dart';

void main() => runApp(InventoryApp());

class InventoryItem {
  final int productId;
  final String name;
  final String imageUrl;

  InventoryItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      productId: json['product_id'],
      name: json['product_name'],
      imageUrl: json['image'],
    );
  }
}

class productInventory {
  final int productInventoryId;
  final int price;
  final int availableAmount;
  final int listedAmount;
  final int vendorVendorId;
  final int productProductId;

  productInventory({
    required this.productInventoryId,
    required this.price,
    required this.availableAmount,
    required this.listedAmount,
    required this.vendorVendorId,
    required this.productProductId,
  });

  factory productInventory.fromJson(Map<String, dynamic> json) {
    return productInventory(
      productInventoryId: json['product_inventory_id'],
      price: json['price'],
      availableAmount: json['available_amount'],
      listedAmount: json['listed_amount'],
      vendorVendorId: json['vendor_vendor_id'],
      productProductId: json['product_product_id'],
    );
  }
}

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
                Navigator.pop(context);
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

                    print(imageUrl);

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
              onDelete: () {}),
        ),
      );
    }

    if (isDuplicate) {
      print('Product is a duplicate');
      _showDuplicateProductAlert(productProductId);
    } else {
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
    );
  }
}

class Inventory extends StatefulWidget {
  const Inventory({Key? key}) : super(key: key);

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  List<productInventory> productInventories = [];
  final List<productInventory> inventoryItems = [];
  List<InventoryItem> suggestions = [];

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

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayProductInventories("1");
    _fetchAndDisplayCombinedData("1");
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
        ),
      ),
    );
  }


}

class ProductDetailsPage extends StatelessWidget {

  final InventoryItem product;
  final Function(String, String, String, int, int) addToInventoryCallback;

  ProductDetailsPage({
    required this.product,
    required this.addToInventoryCallback,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController listedAmountController = TextEditingController();
    TextEditingController availableAmountController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xFFFF9100),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(AppLocalizations.of(context)!.app_name),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 655, // Increased height of the background card
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    product.imageUrl != null
                        ? Image.network(
                      "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/" + product.imageUrl,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    )
                        : Container(),
                    SizedBox(height: 12),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeadingWithIcon(
                          context,
                          "Available Qty",
                          Icons.edit,
                        ),
                        _buildHeadingWithIcon(
                          context,
                          "Listed Qty",
                          Icons.edit,
                        ),
                        _buildHeadingWithIcon(
                          context,
                          "Unit Cost",
                          Icons.edit,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSmallShadowBoxTextField(
                          context,
                          listedAmountController,
                          " ", // Static label
                        ),
                        _buildSmallShadowBoxTextField(
                          context,
                          availableAmountController,
                          " ", // Static label
                        ),
                        _buildSmallShadowBoxTextField(
                          context,
                          priceController,
                          "", // Static label
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        String listedAmount = listedAmountController.text;
                        String availableAmount = availableAmountController.text;
                        String price = priceController.text;
                        int vendorId = 1; // Example vendorId

                        addToInventoryCallback(listedAmount, availableAmount, price, vendorId, product.productId);
                      },
                      child: Text(AppLocalizations.of(context)!.add),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingWithIcon(
      BuildContext context, String heading, IconData icon) {
    return Row(
      children: [
        Text(heading),
        Icon(icon),
      ],
    );
  }

  Widget _buildSmallShadowBoxTextField(
      BuildContext context,
      TextEditingController controller,
      String labelText,
      ) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
        ),
      ),
    );
  }
}







