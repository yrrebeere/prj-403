import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  List<InventoryItem> suggestions = [];
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
        backgroundColor: Color(0xFF6FB457),
        centerTitle: true,
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
                      labelText: 'Search',
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
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
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
    );
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


    return showDialog<InventoryItem>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero, // Set contentPadding to zero
        content: SingleChildScrollView(
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
                  decoration: InputDecoration(labelText: 'Listed Amount'),
                ),
                TextFormField(
                  controller: availableAmountController,
                  decoration: InputDecoration(labelText: 'Available Amount'),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    String listedAmount = listedAmountController.text;
                    String availableAmount = availableAmountController.text;
                    String price = priceController.text;

                    print(listedAmount); print("AHAHAHA"); print(availableAmount); print("NANANA"); print(price);

                    await _addToInventory(listedAmount, availableAmount, price, vendorId, product.productId);

                    Navigator.pop(context, product);
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addToInventory(
      String listedAmount,
      String availableAmount,
      String price,
      int vendorId,
      int productProductId
      ) async {
    print("dsgsgbdsdhngs");
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/api/product_inventory/addproductinventory'),
      body: jsonEncode({
        'listed_amount' : listedAmount,
        'available_amount' : availableAmount,
        'price' : price,
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

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayProductInventories("1");
  }

  Future<void> _fetchAndDisplayProductInventories(String vendorId) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/api/product_inventory/search/$vendorId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        print(response.body);
        productInventories = data.map((item) => productInventory.fromJson(item)).toList();
      });
    } else {
      print('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 145),
          child: Text('WASAIL'),
        ),
        elevation: 0,
      ),
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
                            '${productInventories.length} Listed SKUs',
                            style: TextStyle(fontSize: 24),
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
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // _openItemDetails(item);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${item.productInventoryId}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Icon(Icons.arrow_forward_ios,
                                                color: Colors.black),
                                          ),
                                        ],
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => SearchBarPage()),
      //     );
      //
      //     if (result != null && result is InventoryItem) {
      //       setState(() {
      //         inventoryItems.add(result);
      //       });
      //     }
      //   },
      //   backgroundColor: Color(0xFF6FB457),
      //   child: Icon(Icons.add),
      // ),
    );
  }

  void _openItemDetails(InventoryItem item) {
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

class ItemDetailsPage extends StatelessWidget {
  final InventoryItem item;
  final VoidCallback onDelete;

  const ItemDetailsPage({required this.item, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        image: DecorationImage(
                          image: NetworkImage(item.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      item.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        onDelete();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: Text('Delete Item'),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
}
