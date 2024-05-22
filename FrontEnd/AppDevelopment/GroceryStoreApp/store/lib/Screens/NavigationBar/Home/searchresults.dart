import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/Screens/NavigationBar/Home/vendordetails.dart';
import '../../../Classes/product.dart';
import '../../../Classes/product_inventory.dart';
import '../../../Classes/vendor.dart';
import 'home.dart';

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
                          radius: 70, // Increase the radius for a larger image
                          backgroundImage: NetworkImage("https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+vendor.vendorImage),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.0),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Color(0xFF6FB457),
                              ),
                              child: Text(
                                vendor.vendorName,
                                style: TextStyle(fontSize: 20.0, color: Colors.white),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'See Vendor Details',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Color(0xFF6FB457),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(width: 8.0),
                                Icon(Icons.double_arrow_outlined,
                                    size: 17.0, color: Color(0xFF6FB457)),
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