import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:provider/provider.dart';
import 'inventory.dart';

class ItemDetailsPage extends StatefulWidget {
  final productInventory item;
  final VoidCallback onDelete;

  const ItemDetailsPage({
    required this.item,
    required this.onDelete,
  });

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  late TextEditingController listedAmountController;
  late TextEditingController availableAmountController;
  late TextEditingController priceController;
  late String productName;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    productName = "";
    imageUrl = "";
    listedAmountController = TextEditingController(
        text: widget.item.listedAmount.toString());
    availableAmountController = TextEditingController(
        text: widget.item.availableAmount.toString());
    priceController =
        TextEditingController(text: widget.item.price.toString());

    _fetchAndDisplayProductDetails(widget.item.productProductId);
  }

  Future<void> _fetchAndDisplayProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/$productId'),
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
      appBar: AppBar(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
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
                      imageUrl != null
                          ? Image.asset(
                        imageUrl,
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                      )
                          : Container(),
                      SizedBox(height: 12),
                      Text(
                        productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      SizedBox(height: 25),
                      GestureDetector(
                        onTap: () async {
                          widget.onDelete();
                          Navigator.pop(context);
                          await _deleteProductInventoryConfirmation();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHeadingWithIcon('Available Qty', Icons.edit),
                          _buildHeadingWithIcon(
                              'Listed Qty', Icons.edit),
                          _buildHeadingWithIcon('Unit Cost', Icons.edit),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSmallShadowBoxTextField(listedAmountController),
                          _buildSmallShadowBoxTextField(
                              availableAmountController),
                          _buildSmallShadowBoxTextField(priceController),
                        ],
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

  Widget _buildHeadingWithIcon(String heading, IconData icon) {
    return Row(
      children: [
        Text(heading),
        Icon(icon),
      ],
    );
  }

  Widget _buildSmallShadowBoxTextField(TextEditingController controller) {
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
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
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
            'https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_inventory/$productInventoryId'),
      );
      if (response.statusCode == 200) {
        widget.onDelete();
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
            'https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_inventory/$productInventoryId'),
        body: jsonEncode({
          'price': price,
          'available_amount': availableAmount,
          'listed_amount': listedAmount,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
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


