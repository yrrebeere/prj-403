import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'vendordetails.dart';
import 'dart:convert';
import 'package:store/Screens/NavigationBar/Inventory/inventory.dart';

class Category {
  final String name;
  final String imageUrl;

  Category({
    required this.name,
    required this.imageUrl,
  });
}

class Product {
  final int productId;
  final String productName;
  final String image;

  Product({
    required this.productId,
    required this.productName,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      productName: json['product_name'],
      image: json['image'],
    );
  }
}

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

class Vendor{
  final int vendorId;
  final String vendorName;
  final String vendorImage;
  final String vendorAddress;

  Vendor({
    required this.vendorId,
    required this.vendorName,
    required this.vendorImage,
    required this.vendorAddress
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      vendorImage: json['image'],
      vendorAddress: json['delivery_locations'],
    );
  }

}

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
        backgroundColor: Color(0xFF6FB457),
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

          return Card(
            elevation: 3,
            margin: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
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
                          builder: (context) => VendorDetailsPage(vendorId: vendor.vendorId),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(vendor.vendorImage),
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          vendor.vendorName,
                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFF6FB457)),
                        ),
                      ],
                    ),
                  ),
                ),


                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0, // Adjusted tile size
                  ),
                  itemCount: vendorProducts.length,
                  itemBuilder: (context, productIndex) {
                    final product = vendorProducts[productIndex];
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

                    return Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0)),
                              child: Image.asset(
                                product.image,
                                fit: BoxFit.cover,
                                height: 100, // Reduced image size
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName,
                                  style: TextStyle(fontSize: 16.0),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  '\Rs. ${productInventory.price}',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/product_category/allproductcategories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          categories = data.map<Category>((item) => Category(
            name: item['category_name'],
            imageUrl: item['image'],
          )).toList();
        });
      } else {
        print('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _search() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/product/searchproductinstore/${searchController.text}'),
      );


      if (response.statusCode == 200) {

        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> products = responseBody['products'];
        final List<dynamic> productInventories = responseBody['productInventories'];
        final List<dynamic> vendors = responseBody['vendors'];

        List<Product> searchProducts = products.map<Product>((item) => Product.fromJson(item)).toList();
        List<ProductInventory> searchProductInventories = productInventories.map<ProductInventory>((item) => ProductInventory.fromJson(item)).toList();
        List<Vendor> searchVendors = vendors.map<Vendor>((item) => Vendor.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchResultsPage(products: searchProducts, productInventories: searchProductInventories, vendors: searchVendors)),
        );
      } else {
        print('Failed to search products');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void onCategoryTileClicked(String categoryName) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/product_category/searchcategoryinstore/$categoryName'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> products = responseBody['products'];
        final List<dynamic> productInventories = responseBody['productInventories'];
        final List<dynamic> vendors = responseBody['vendors'];

        List<Product> searchProducts = products.map<Product>((item) => Product.fromJson(item)).toList();
        List<ProductInventory> searchProductInventories = productInventories.map<ProductInventory>((item) => ProductInventory.fromJson(item)).toList();
        List<Vendor> searchVendors = vendors.map<Vendor>((item) => Vendor.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchResultsPage(products: searchProducts, productInventories: searchProductInventories, vendors: searchVendors)),
        );
      } else {
        print('Failed to search products');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _search,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                children: categories.map((category) {
                  return GestureDetector(
                    onTap: () => onCategoryTileClicked(category.name),
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            category.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 8.0),
                          Text(category.name),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
