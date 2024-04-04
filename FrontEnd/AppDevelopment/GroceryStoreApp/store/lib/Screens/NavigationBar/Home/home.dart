import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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

class Vendor {
  final int vendorId;
  final String vendorName;
  final String vendorImage;
  final String vendorAddress;

  Vendor(
      {required this.vendorId,
      required this.vendorName,
      required this.vendorImage,
      required this.vendorAddress});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorId: json['vendor_id'],
      vendorName: json['vendor_name'],
      vendorImage: json['image'],
      vendorAddress: json['delivery_locations'],
    );
  }
}


class CartItem {
  final Product product;
  final ProductInventory productInventory;

  CartItem({
    required this.product,
    required this.productInventory,
  });
}

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(Product product, ProductInventory productInventory) {
    _cartItems.add(CartItem(product: product, productInventory: productInventory));
    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
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
                          builder: (context) =>
                              VendorDetailsPage(vendorId: vendor.vendorId),
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(vendor.vendorImage),
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 30.0),

                            Container(
                              padding: EdgeInsets.all(8.0),
                              // Adjust padding as needed
                              decoration: BoxDecoration(
                                color: Color(0xFF6FB457),
                                // Specify the color of the box
                                borderRadius: BorderRadius.circular(
                                    8.0),
                              ),
                              child: Text(
                                vendor.vendorName,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors
                                        .white),
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
                                      decoration: TextDecoration
                                          .underline), // Adjust text color if needed
                                ),
                                SizedBox(width: 8.0),
                                // Add space between the "See Details" text and the icon
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
                // Recommendation block will go here
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
  ScrollController _scrollController = ScrollController();
  List<Category> categories = [];
  TextEditingController searchController = TextEditingController();

  CartProvider cartProvider = CartProvider();

  @override
  void initState() {
    super.initState();
    cartProvider = CartProvider();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:3000/api/product_category/allproductcategories'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          categories = data
              .map<Category>((item) => Category(
                    name: item['category_name'],
                    imageUrl: item['image'],
                  ))
              .toList();
        });
      } else {
        print('Failed to load categories');
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

  Future<void> _search(BuildContext context) async {
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


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => cartProvider,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          _search(context);
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'Assets/Images/Ads.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 3.0),
                Container(
                  height: 48,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF6FB457),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            // Scroll the list to the left
                            _scrollController.animateTo(
                              _scrollController.offset -
                                  MediaQuery.of(context).size.width,
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                        ),
                        Text(
                          'Recommendations',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            _scrollController.animateTo(
                              _scrollController.offset +
                                  MediaQuery.of(context).size.width,
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildRecommendedProduct('Dalda Cooking Oil \n5Kg',
                          'Rs. 2725', 'Assets/Images/Products/dalda-oil.jpeg'),
                      _buildRecommendedProduct(
                          'Sunrise Wheat Flour \n10Kg',
                          'Rs. 1800',
                          'Assets/Images/Products/sunrise-flour.jpeg'),
                      _buildRecommendedProduct('Olpers Milk \n6 Pack', 'Rs. 2800',
                          'Assets/Images/Products/olpers-milk.jpg'),
                      _buildRecommendedProduct('Knorr Ketchup', 'Rs. 240',
                          'Assets/Images/Products/knorr-ketchup.png'),
                      _buildRecommendedProduct('Nestle Milk \n6 Pack', 'Rs. 2450',
                          'Assets/Images/Products/nestle-milk.jpg'),
                      _buildRecommendedProduct('Dasani Water', 'Rs. 170',
                          'Assets/Images/Products/dasani-water.png'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF6FB457),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  children: categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        onCategoryTileClicked(category.name);
                      },
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedProduct(
      String productName, String productPrice, String imagePath) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 90,
            height: 90,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            productName,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productPrice,
                style: TextStyle(fontSize: 15.0),
              ),
            ]
          ),
        ],
      ),
    );
  }
}
