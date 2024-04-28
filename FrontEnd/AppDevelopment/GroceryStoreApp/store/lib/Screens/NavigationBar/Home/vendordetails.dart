import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VendorDetailsPage extends StatefulWidget {
  final int vendorId;

  const VendorDetailsPage({Key? key, required this.vendorId}) : super(key: key);

  @override
  _VendorDetailsPageState createState() => _VendorDetailsPageState();
}

class _VendorDetailsPageState extends State<VendorDetailsPage> {
  late Future<Map<String, dynamic>> _vendorProfile;
  bool _isVendorAdded = false; // Track if vendor is added to the list
  int vendorId = 1;
  @override
  void initState() {
    super.initState();
    _vendorProfile = fetchVendorProfile(widget.vendorId);
  }

  Future<Map<String, dynamic>> fetchVendorProfile(int vendorId) async {
    final response =
    await http.get(Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/vendorprofile/$vendorId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      return responseBody;
    } else {
      throw Exception('Failed to load vendor profile');
    }
  }

  void _addVendorToList() async {
    try {

      final response = await http.post(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/list/addvendorlist/1/1'),
        // You can add any additional data needed for the request, such as headers or body
      );

      if (response.statusCode == 201) {
        // Update _isVendorAdded and show a success message
        setState(() {
          _isVendorAdded = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vendor added successfully')),
        );
      } else {
        // Show an error message if the request fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vendor already exists in list. Thankyou.')),
        );
      }
    } catch (error) {
      // Handle any exceptions or errors that occur during the request
      print('Error adding vendor: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding vendor. Please try again later.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        flexibleSpace: Container(
          color: Color(0xFF6FB457),
        ),
        title: Text(
          'Vendor Details',
          textAlign: TextAlign.center,
          style: TextStyle(

            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true, // This line will align the title to the center
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: _vendorProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final vendorProfile = snapshot.data!['vendor'];
            final productInventories = snapshot.data!['productInventories'];
            final products = snapshot.data!['products'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      if (vendorProfile['image'] != null)
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(vendorProfile['image']),
                        ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start (left) horizontally
                          children: [
                            Container(
                              padding: EdgeInsets.all(8), // Padding around the text
                              decoration: BoxDecoration(
                                color: Color(0xFF6FB457), // Color of the container
                                borderRadius: BorderRadius.circular(8), // Border radius of the container
                              ),
                              child: Text(
                                '${vendorProfile['vendor_name']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white, // Text color set to white
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(8), // Padding around the text
                              decoration: BoxDecoration(
                                color: Color(0xFF6FB457), // Color of the container
                                borderRadius: BorderRadius.circular(8), // Border radius of the container
                              ),
                              child: Text(
                                '${vendorProfile['delivery_locations']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white, // Text color set to white
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: _addVendorToList,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: _isVendorAdded ? Colors.green : Color(0xFF6FB457),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Icon(
                              _isVendorAdded ? Icons.check : Icons.add,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFF6FB457), // Color of the container
                      borderRadius: BorderRadius.circular(8), // Border radius of the container
                    ),
                    child: Text(
                      'Inventory',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Text color set to white
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: productInventories.length,
                    itemBuilder: (context, index) {
                      final productInventory = productInventories[index];
                      final product = products.firstWhere(
                              (prod) => prod['product_id'] == productInventory['product_product_id']);
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          leading: Image.asset(
                            product['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            '${product['product_name']}',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: Rs. ${productInventory['price']}'),
                              Text('Available Amount: ${productInventory['available_amount']}'),
                            ],
                          ),
                        ),
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
