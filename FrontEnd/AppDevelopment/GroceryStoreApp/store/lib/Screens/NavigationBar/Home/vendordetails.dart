import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductInventory {
  final int productInventoryId;
  final int price;
  final int availableAmount;
  final int listedAmount;
  final int vendorVendorId;
  final int productProductId;

  ProductInventory({
    required this.productInventoryId,
    required this.price,
    required this.availableAmount,
    required this.listedAmount,
    required this.vendorVendorId,
    required this.productProductId,
  });

  factory ProductInventory.fromJson(Map<String, dynamic> json) {
    return ProductInventory(
      productInventoryId: json['product_inventory_id'],
      price: json['price'],
      availableAmount: json['available_amount'],
      listedAmount: json['listed_amount'],
      vendorVendorId: json['vendor_vendor_id'],
      productProductId: json['product_product_id'],
    );
  }
}

class Vendor {
  final int vendorId;
  final String vendorName;
  final String deliveryLocations;
  final String vendorImage;
  final List<ProductInventory> inventories;

  Vendor({
    required this.vendorId,
    required this.vendorName,
    required this.deliveryLocations,
    required this.vendorImage,
    required this.inventories,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    List<ProductInventory> inventories = (json['inventories'] as List)
        .map((inventoryJson) => ProductInventory.fromJson(inventoryJson))
        .toList();

    return Vendor(
      vendorId: json['vendor']['vendor_id'],
      vendorName: json['vendor']['vendor_name'],
      deliveryLocations: json['vendor']['delivery_locations'],
      vendorImage: json['vendor']['image'],
      inventories: inventories,
    );
  }
}

class VendorDetailsPage extends StatefulWidget {
  final int vendorId;

  const VendorDetailsPage({Key? key, required this.vendorId}) : super(key: key);

  @override
  _VendorDetailsPageState createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage> {
  late Future<Vendor> _vendorDetailsFuture = _fetchVendorDetails();

  Future<Vendor> _fetchVendorDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/vendor/vendorprofile/${widget.vendorId}'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        return Vendor.fromJson(responseBody);
      } else {
        throw Exception('Failed to load vendor details');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch vendor details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Details'),
      ),
      body: FutureBuilder<Vendor>(
        future: _vendorDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final Vendor vendor = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Vendor Name: ${vendor.vendorName}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Delivery Locations: ${vendor.deliveryLocations}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Image.asset(
                  vendor.vendorImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vendor.inventories.length,
                    itemBuilder: (context, index) {
                      final inventory = vendor.inventories[index];
                      return ListTile(
                        title: Text('Price: ${inventory.price}'),
                        subtitle: Text('Available Amount: ${inventory.availableAmount}'),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
