import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:store/Screens/NavigationBar/Home/searchresults.dart';
import '../../../Classes/cart_provider.dart';
import '../../../Classes/category.dart';
import '../../../Classes/product.dart';
import '../../../Classes/product_inventory.dart';
import '../../../Classes/vendor.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  List<Category> categories = [];
  TextEditingController searchController = TextEditingController();

  late CartProvider cartProvider;

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
            'https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/allproductcategories'),
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
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/searchcategoryinstore/$categoryName'),
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
    final searchText = searchController.text.trim();
    if (searchText.isEmpty) {
      return; // Do nothing if the search text is empty
    }

    print('Search query: $searchText');

    try {
      // Attempt to search by product name
      final productResponse = await http.get(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product/searchproductinstore/$searchText'),
      );

      if (productResponse.statusCode == 200) {
        final Map<String, dynamic> productResponseBody = jsonDecode(productResponse.body);
        final List<dynamic> products = productResponseBody['products'];
        final List<dynamic> productInventories = productResponseBody['productInventories'];
        final List<dynamic> vendors = productResponseBody['vendors'];

        List<Product> searchProducts = products.map<Product>((item) => Product.fromJson(item)).toList();
        List<ProductInventory> searchProductInventories = productInventories.map<ProductInventory>((item) => ProductInventory.fromJson(item)).toList();
        List<Vendor> searchVendors = vendors.map<Vendor>((item) => Vendor.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchResultsPage(products: searchProducts, productInventories: searchProductInventories, vendors: searchVendors)),
        );
        return; // Exit function after processing product search
      }

      // If not found in products, attempt to search by category name
      final categoryResponse = await http.get(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/product_category/searchcategoryinstore/$searchText'),
      );

      if (categoryResponse.statusCode == 200) {
        final Map<String, dynamic> categoryResponseBody = jsonDecode(categoryResponse.body);
        final List<dynamic> products = categoryResponseBody['products'];
        final List<dynamic> productInventories = categoryResponseBody['productInventories'];
        final List<dynamic> vendors = categoryResponseBody['vendors'];

        List<Product> searchProducts = products.map<Product>((item) => Product.fromJson(item)).toList();
        List<ProductInventory> searchProductInventories = productInventories.map<ProductInventory>((item) => ProductInventory.fromJson(item)).toList();
        List<Vendor> searchVendors = vendors.map<Vendor>((item) => Vendor.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchResultsPage(products: searchProducts, productInventories: searchProductInventories, vendors: searchVendors)),
        );
        return; // Exit function after processing category search
      }

      // If not found in categories, attempt to search by vendor name
      final vendorResponse = await http.get(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/searchvendorinstore/$searchText'),
      );

      if (vendorResponse.statusCode == 200) {
        final Map<String, dynamic> vendorResponseBody = jsonDecode(vendorResponse.body);
        final List<dynamic> vendors = vendorResponseBody['vendors'];

        List<Vendor> searchVendors = vendors.map<Vendor>((item) => Vendor.fromJson(item)).toList();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchResultsPage(vendors: searchVendors, products: [], productInventories: [],)),
        );
        return; // Exit function after processing vendor search
      }

      // Handle failure if no results found in products, categories, or vendors
      print('Failed to find products, categories, or vendors');
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
                TextField(
                  controller: searchController, 
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
                Container(
                  height: 130,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, bottom: 8),
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
                  height: 43,
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                          ),
                          color: Color(0xFF6FB457),
                          onPressed: () {
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
                          style: TextStyle(fontSize: 20.0, color: Color(0xFF6FB457)),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                          color: Color(0xFF6FB457),
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
                      _buildRecommendedProduct(
                          'Lays Masala',
                          'Rs. 60',
                          'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/products/lays-masala.png'
                      ),
                      _buildRecommendedProduct(
                          'Cheetos Salted',
                          'Rs. 40',
                          'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/products/cheetos-salted.jpg'
                      ),
                      _buildRecommendedProduct(
                          'Lipton Tea',
                          'Rs. 515',
                          'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/products/lipton-tea.png'
                      ),
                      _buildRecommendedProduct(
                          'Olpers Milk',
                          'Rs. 170',
                          'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/products/olpers-milk.jpg'
                      ),
                      _buildRecommendedProduct(
                          'K&N Nuggets',
                          'Rs. 1200',
                          'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/products/k&n-nuggets.jpg'),
                      _buildRecommendedProduct(
                          'Nestle Yogurt',
                          'Rs. 165',
                          'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/products/nestle-yogurt.jpg'
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 43,
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(fontSize: 20.0, color: Color(0xFF6FB457)),
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
                        print('Category tapped');
                        onCategoryTileClicked(category.name);
                      },
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+category.imageUrl,
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
          Image.network(
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
