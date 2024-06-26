import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Classes/product_inventory.dart';
import 'Classes/api.dart';

void main() => runApp(
  MyApp(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductInventoryScreen(),
    );
  }
}

class ProductInventoryScreen extends StatefulWidget {
  @override

  _ProductInventoryScreenState createState() => _ProductInventoryScreenState();
}

class _ProductInventoryScreenState extends State<ProductInventoryScreen> {
  TextEditingController productInventoryIdController = TextEditingController();
  List<productInventory> _productInventoryList = [];

  @override
  void initState() {
    super.initState();
    _fetchAllProductInventories();
  }

  Future<void> _fetchAllProductInventories() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product_inventory/allproductinventories'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      setState(() {
        _productInventoryList = jsonList.map((item) => productInventory.fromJson(item)).toList();
      });
    } else {
      print('Failed to load product inventory');
    }
  }

  Future<void> _fetchProductInventoryById() async {
    TextEditingController idController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fetch Product Inventory by ID'),
          content: Column(
            children: [
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Product Inventory ID'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _fetchProductInventory(int.parse(idController.text));
              },
              child: Text('Fetch'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchProductInventory(int productInventoryId) async {
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}/api/product_inventory/$productInventoryId'));

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      setState(() {
        _productInventoryList = [productInventory.fromJson(json)];
      });
    } else {
      print('Failed to load product inventory by ID');
    }
  }

  Future<void> _addProductInventory() async {
    TextEditingController priceController = TextEditingController();
    TextEditingController availableAmountController = TextEditingController();
    TextEditingController listedAmountController = TextEditingController();
    TextEditingController vendorIdController = TextEditingController();
    TextEditingController productIdController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Product Inventory'),
          content: Column(
            children: [
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: availableAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Available Amount'),
              ),
              TextField(
                controller: listedAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Listed Amount'),
              ),
              TextField(
                controller: vendorIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Vendor Id'),
              ),
              TextField(
                controller: productIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Id'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _createProductInventory(
                  int.parse(priceController.text),
                  int.parse(availableAmountController.text),
                  int.parse(listedAmountController.text),
                  int.parse(vendorIdController.text),
                  int.parse(productIdController.text),
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createProductInventory(int price, int availableAmount, int listedAmount, int vendorId, int productId) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/product_inventory/addproductinventory'),
      body: jsonEncode({
        'price': price,
        'available_amount': availableAmount,
        'listed_amount': listedAmount,
        'vendor_vendor_id': vendorId,
        'product_product_id': productId,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print("Product Inventory added");
    } else {
      throw Exception('Failed to add product inventory');
    }
  }

  Future<void> _updateProductInventory(int productInventoryId) async {

    TextEditingController priceController = TextEditingController();
    TextEditingController availableAmountController = TextEditingController();
    TextEditingController listedAmountController = TextEditingController();
    TextEditingController vendorIdController = TextEditingController();
    TextEditingController productIdController = TextEditingController();

    productInventory existingProductInventory = await _fetchProductInventoryDetails(productInventoryId);

    priceController.text = existingProductInventory.price.toString();
    availableAmountController.text = existingProductInventory.availableAmount.toString();
    listedAmountController.text = existingProductInventory.listedAmount.toString();
    vendorIdController.text = existingProductInventory.vendorVendorId.toString();
    productIdController.text = existingProductInventory.productProductId.toString();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Product Inventory'),
          content: Column(
            children: [
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextField(
                controller: availableAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Available Amount'),
              ),
              TextField(
                controller: listedAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Listed Amount'),
              ),
              TextField(
                controller: vendorIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Vendor Id'),
              ),
              TextField(
                controller: productIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Id'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _performUpdate(
                  productInventoryId,
                  priceController.text,
                  availableAmountController.text,
                  listedAmountController.text,
                  vendorIdController.text,
                  productIdController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<productInventory> _fetchProductInventoryDetails(int productInventoryId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/product_inventory/$productInventoryId'),
    );

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);
      return productInventory.fromJson(json);
    } else {
      print('Failed to load product inventory details by ID');
      throw Exception('Failed to load product inventory details by ID');
    }
  }

  Future<void> _performUpdate(
      int productInventoryId,
      String price,
      String availableAmount,
      String listedAmount,
      String vendorId,
      String productId,

      ) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/api/product_inventory/$productInventoryId'),
        body: jsonEncode({
          'price': price,
          'available_amount': availableAmount,
          'listed_amount': listedAmount,
          'vendor_vendor_id': vendorId,
          'product_product_id': productId,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await _fetchAllProductInventories();

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

  void _showUpdateProductInventoryDialog() async {
    TextEditingController idController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Product Inventory by ID'),
          content: Column(
            children: [
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Enter Product Inventory ID'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _updateProductInventory(int.parse(idController.text));
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProductInventoryConfirmation(BuildContext context, int productInventoryId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Product Inventory'),
          content: Text('Are you sure you want to delete this product inventory?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteProductInventory(productInventoryId);
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
    final response = await http.delete(
      Uri.parse('${ApiConstants.baseUrl}/api/product_inventory/$productInventoryId'),
    );

    if (response.statusCode == 200) {
      await _fetchAllProductInventories();

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Inventory Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _fetchAllProductInventories(),
            child: Text('Fetch All Products Inventory'),
          ),
          ElevatedButton(
            onPressed: () => _fetchProductInventoryById(),
            child: Text('Fetch Product Inventory by ID'),
          ),
          ElevatedButton(
            onPressed: () {
              _showUpdateProductInventoryDialog();
            },
            child: Text('Update Product Inventory'),
          ),
          ElevatedButton(
            onPressed: () => _addProductInventory(),
            child: Text('Add Product Inventory'),
          ),
          if (_productInventoryList.isNotEmpty)
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _fetchAllProductInventories();
                },
                child: ListView.builder(
                  itemCount: _productInventoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Product ID: ${_productInventoryList[index].productProductId}'),
                      subtitle: Text('Price: ${_productInventoryList[index].price}'),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await _deleteProductInventoryConfirmation(
                              context, _productInventoryList[index].productInventoryId);
                        },
                        child: Text('Delete'),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
