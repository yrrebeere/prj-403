import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home.dart';
import '../navbar.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final ProductInventory productInventory;

  const ProductDetailsPage({
    Key? key,
    required this.product,
    required this.productInventory,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 0;
  int? weeklyRecommendation;
  int? monthlyRecommendation;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: quantity.toString());
    _fetchRecommendation('weekly');
    _fetchRecommendation('monthly');
    print(widget.product);
  }

  Future<void> _fetchRecommendation(String type) async {
    final model = "xgb";
    final storeNumber = "8";
    final productNumber = widget.product.productNumber;

    final url = type == 'weekly'
        ? 'https://sea-lion-app-wbl8m.ondigitalocean.app/api/prediction/sendweeklyprediction/$model/$storeNumber/$productNumber'
        : 'https://sea-lion-app-wbl8m.ondigitalocean.app/api/prediction/sendmonthlyprediction/$model/$storeNumber/$productNumber';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (type == 'weekly') {
            weeklyRecommendation = data;
          } else {
            monthlyRecommendation = data;
          }
        });
      } else {
        throw Exception('Failed to load recommendation');
      }
    } catch (error) {
      print('Error fetching recommendation: $error');
    }
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      _quantityController.text = newQuantity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              color: Color(0xFF6FB457),
            ),
            title: Text('Product Details', textAlign: TextAlign.center),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/" + widget.product.image,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Product Name: ${widget.product.productName}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Price: Rs. ${widget.productInventory.price}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text('Weekly Recommendation :', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (weeklyRecommendation != null) {
                          _updateQuantity(weeklyRecommendation!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          weeklyRecommendation != null
                              ? '$weeklyRecommendation'
                              : 'Fetching...',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Monthly Recommendation :', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (monthlyRecommendation != null) {
                          _updateQuantity(monthlyRecommendation!);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          monthlyRecommendation != null
                              ? '$monthlyRecommendation'
                              : 'Fetching...',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildInputField(
                    'Quantity',
                    _quantityController,
                        (value) {
                      setState(() {
                        quantity = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      final cartProvider = Provider.of<CartProvider>(
                        context,
                        listen: false,
                      );
                      cartProvider.addToCart(
                        widget.product,
                        widget.productInventory,
                        quantity,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${widget.product.productName} to the cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(quantity: quantity),
                        ),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF6FB457),
                    ),
                    child: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(
      String label,
      TextEditingController controller,
      ValueChanged<String> onChanged,
      ) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }
}
