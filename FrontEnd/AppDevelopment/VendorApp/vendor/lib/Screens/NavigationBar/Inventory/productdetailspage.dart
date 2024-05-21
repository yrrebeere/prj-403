import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Classes/inventory_item.dart';
import 'package:http/http.dart' as http;

class ProductDetailsPage extends StatefulWidget {
  final InventoryItem product;
  final Function(String, String, String, int, int) addToInventoryCallback;

  ProductDetailsPage({
    required this.product,
    required this.addToInventoryCallback,
  });

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late TextEditingController listedAmountController;
  late TextEditingController availableAmountController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    listedAmountController = TextEditingController();
    availableAmountController = TextEditingController();
    priceController = TextEditingController();
  }

  @override
  void dispose() {
    listedAmountController.dispose();
    availableAmountController.dispose();
    priceController.dispose();
    super.dispose();
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
          icon: Icon(Icons.arrow_back_ios),
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
              height: 655,
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
                    widget.product.imageUrl != null
                        ? Image.network(
                      "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/" +
                          widget.product.imageUrl,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    )
                        : Container(),
                    SizedBox(height: 12),
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeadingWithIcon("Available Qty", Icons.edit),
                        _buildHeadingWithIcon("Listed Qty", Icons.edit),
                        _buildHeadingWithIcon("Unit Cost", Icons.edit),
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
                      onPressed: () {
                        String listedAmount = listedAmountController.text.trim();
                        String availableAmount = availableAmountController.text.trim();
                        String price = priceController.text.trim();
                        int vendorId = 7; // Example vendorId

                        widget.addToInventoryCallback(
                          listedAmount,
                          availableAmount,
                          price,
                          vendorId,
                          widget.product.productId,
                        );

                        Navigator.pop(context);
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
}
