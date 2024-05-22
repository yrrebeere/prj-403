import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Screens/NavigationBar/Home/producttile.dart';
import 'package:store/Screens/NavigationBar/Home/vendordetails.dart';
import '../../../Classes/product.dart';
import '../../../Classes/product_inventory.dart';
import '../../../Classes/vendor.dart';

class SearchResultsPage extends StatelessWidget {
  final List<Product> products;
  final List<ProductInventory> productInventories;
  final List<Vendor> vendors;

  const SearchResultsPage({
    Key? key,
    required this.products,
    required this.productInventories,
    required this.vendors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          color: Color(0xFF6FB457),
        ),
        title: Text('Search Results', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: vendors.length,
        itemBuilder: (context, vendorIndex) {
          final vendor = vendors[vendorIndex];
          final vendorProducts = products.where((product) {
            final productInventory = productInventories.firstWhere(
                  (inventory) => inventory.productProductId == product.productId,
              orElse: () => ProductInventory(
                productInventoryId: -1,
                price: 0,
                availableAmount: 0,
                listedAmount: 0,
                vendorVendorId: -1,
                productProductId: product.productId,
              ),
            );
            return productInventory.vendorVendorId == vendor.vendorId;
          }).toList();

          return Container(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VendorDetailsPage(vendorId: vendor.vendorId),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 55, // Increase the radius for a larger image
                          backgroundImage: NetworkImage("https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+vendor.image),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.0),
                            Container(
                              child: Text(
                                vendor.vendorName,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF6FB457),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'See Vendor Details',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blueAccent,
                                  ),
                                ),
                                Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 17.0, color: Colors.blueAccent
                                ),
                                // Arrow icon
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // GridView for products
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  physics: NeverScrollableScrollPhysics(),
                  children: vendorProducts.map((product) {
                    final productInventory = productInventories.firstWhere(
                          (inventory) =>
                      inventory.productProductId == product.productId,
                      orElse: () => ProductInventory(
                        productInventoryId: -1,
                        price: 0,
                        availableAmount: 0,
                        listedAmount: 0,
                        vendorVendorId: -1,
                        productProductId: product.productId,
                      ),
                    );

                    return ProductTile(
                      product: product,
                      productInventory: productInventory,
                    );
                  }).toList(),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}