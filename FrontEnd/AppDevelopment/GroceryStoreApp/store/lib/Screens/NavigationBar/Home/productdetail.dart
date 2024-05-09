import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import '../navbar.dart'; // Import NavBar widget

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
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+widget.product.image,
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Product Name: ${widget.product.productName}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Price: Rs. ${widget.productInventory.price}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20.0),
                _buildInputField(
                  'Quantity',
                  quantity.toString(),
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
                        content: Text(
                            'Added ${widget.product.productName} to the cart'),
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
        );
      },
    );
  }

  Widget _buildInputField(
      String label, String initialValue, ValueChanged<String> onChanged) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
