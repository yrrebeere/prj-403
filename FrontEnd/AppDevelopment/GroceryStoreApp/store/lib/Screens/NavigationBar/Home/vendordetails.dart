import 'package:flutter/material.dart';
import 'home.dart'; // Import the necessary classes for Vendor, Product, and ProductInventory

class VendorDetailsPage extends StatelessWidget {
  final Vendor vendor;
  final List<Product> products;
  final List<ProductInventory> productInventories;

  const VendorDetailsPage({
    Key? key,
    required this.vendor,
    required this.products,
    required this.productInventories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter products and inventories for the selected vendor
    final vendorProducts = products.where((product) =>
        productInventories.any((inventory) =>
        inventory.productProductId == product.productId &&
            inventory.vendorVendorId == vendor.vendorId)).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Text('Vendor Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              vendor.vendorImage,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${vendor.vendorName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: vendorProducts.length,
              itemBuilder: (context, index) {
                final product = vendorProducts[index];
                final productInventory = productInventories.firstWhere(
                      (inventory) =>
                  inventory.productProductId == product.productId &&
                      inventory.vendorVendorId == vendor.vendorId,
                  orElse: () => ProductInventory(
                    productInventoryId: -1,
                    price: 0,
                    availableAmount: 0,
                    listedAmount: 0,
                    vendorVendorId: -1,
                    productProductId: product.productId,
                  ),
                );

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(
                      product.image,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text('${product.productName} - Rs. ${productInventory.price}'),
                    subtitle: Text('Available Amount: ${productInventory.availableAmount}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
