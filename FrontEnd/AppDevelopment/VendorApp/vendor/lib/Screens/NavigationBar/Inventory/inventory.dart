import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Screens/NavigationBar/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';

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
            backgroundColor: Color(0xFF6FB457),
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
                        await _showProductDetailsDialog(product);
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(product.name),
                          leading: Image.asset(
                            imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Icon(Icons.error);
                            },
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
      Uri.parse('http://10.0.2.2:3000/api/product/searchproduct/$query'),
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

  Future<InventoryItem?> _showProductDetailsDialog(
    InventoryItem product,
  ) async {
    TextEditingController listedAmountController = TextEditingController();
    TextEditingController availableAmountController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    int vendorId = 1;

    await Future.delayed(Duration(milliseconds: 100));

    return showDialog<InventoryItem>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero, // Set contentPadding to zero
          content: Builder(
            builder: (BuildContext context) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                        ),
                        child: Image.asset(
                          product.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: listedAmountController,
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.listed_amount,
                        ),
                      ),
                      TextFormField(
                        controller: availableAmountController,
                        decoration:
                            InputDecoration(labelText: AppLocalizations.of(context)!.available_amount),
                      ),
                      TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.price),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          String listedAmount = listedAmountController.text;
                          String availableAmount =
                              availableAmountController.text;
                          String price = priceController.text;


                          await _addToInventory(
                            listedAmount,
                            availableAmount,
                            price,
                            vendorId,
                            product.productId,
                          );

                          Navigator.pop(context, product);
                        },
                        child: Text(AppLocalizations.of(context)!.add),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _addToInventory(String listedAmount, String availableAmount,
      String price, int vendorId, int productProductId) async {
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
            'http://10.0.2.2:3000/api/product_inventory/addproductinventory'),
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
      Uri.parse('http://10.0.2.2:3000/api/product_inventory/search/$vendorId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<productInventory> tempProductInventories = [];
      List<InventoryItem> tempSuggestions = [];

      for (final item in data) {
        final productInventoryItem = productInventory.fromJson(item as Map<String, dynamic>);

        final productId = productInventoryItem.productProductId;
        final productInventoryResponse = await http.get(
          Uri.parse('http://10.0.2.2:3000/api/product/$productId'),
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
      Uri.parse('http://10.0.2.2:3000/api/product_inventory/search/$vendorId'),
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
                                            child: Image.asset(
                                              productItem.imageUrl,
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
        backgroundColor: Color(0xFF6FB457),
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

class ItemDetailsPage extends StatefulWidget {
  final productInventory item;

  final VoidCallback onDelete;

  const ItemDetailsPage({
    required this.item,
    required this.onDelete
  });

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late TextEditingController listedAmountController;
  late TextEditingController availableAmountController;
  late TextEditingController priceController;
  late String productName; // Add this line
  late String imageUrl; // Add this line


  @override
  void initState() {
    super.initState();
    productName="";
    imageUrl="";
    listedAmountController =
        TextEditingController(text: widget.item.listedAmount.toString());
    availableAmountController =
        TextEditingController(text: widget.item.availableAmount.toString());
    priceController = TextEditingController(text: widget.item.price.toString());

    _fetchAndDisplayProductDetails(widget.item.productProductId);
  }

  Future<void> _fetchAndDisplayProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/product/$productId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> productData = jsonDecode(response.body);

        setState(() {
          productName = productData['product_name'];
          imageUrl = productData['image'];
        });
      } else {
        print('Failed to load product details');
      }
    } catch (error) {
      print('Error fetching product details: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                height: 650,
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
                    children: [
                      SizedBox(height: 16),
                      Text(
                        productName,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                      SizedBox(height: 16),
                      imageUrl != null
                          ? Image.asset(
                        imageUrl, // Assuming imageUrl is the asset path
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      )
                          : Container(),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: listedAmountController,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.listed_amount),
                      ),
                      TextFormField(
                        controller: availableAmountController,
                        decoration:
                            InputDecoration(labelText: AppLocalizations.of(context)!.available_amount),
                      ),
                      TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(labelText: AppLocalizations.of(context)!.price),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          String listedAmount =
                              listedAmountController.text.trim();
                          String availableAmount =
                              availableAmountController.text.trim();
                          String price = priceController.text.trim();

                          await _updateProductDetails(
                            listedAmount,
                            availableAmount,
                            price,
                            widget.item.productInventoryId,
                          );

                          Navigator.pop(context);
                        },
                        child: Text(AppLocalizations.of(context)!.update),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          widget.onDelete();
                          Navigator.pop(context);
                          await _deleteProductInventoryConfirmation();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text(AppLocalizations.of(context)!.delete),
                      ),
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

  Future<void> _deleteProductInventoryConfirmation() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product Inventory'),
          content:
              Text('Are you sure you want to delete this product inventory?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteProductInventory(widget.item.productInventoryId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProductInventory(int productInventoryId) async {
    try {
      final response = await http.delete(
        Uri.parse(
            'http://10.0.2.2:3000/api/product_inventory/$productInventoryId'),
      );
      if (response.statusCode == 200) {
        widget
            .onDelete(); // Trigger the callback to update the UI in the parent widget
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully deleted!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error deleting: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _updateProductDetails(
    String listedAmount,
    String availableAmount,
    String price,
    int productInventoryId,
  ) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:3000/api/product_inventory/$productInventoryId'),
        body: jsonEncode({
          'price': price,
          'available_amount': availableAmount,
          'listed_amount': listedAmount,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        // await _fetchAllProductInventories();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully updated!'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Error updating: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
