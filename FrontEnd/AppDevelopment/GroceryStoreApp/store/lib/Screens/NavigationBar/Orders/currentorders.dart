import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrentOrdersPage extends StatelessWidget {
  final int vendorId;

  CurrentOrdersPage(this.vendorId);

  Future<List<Map<String, dynamic>>> _fetchAndDisplayCombinedData(int vendorId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/order/storeorderhistory/$vendorId'),
      );


      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> combinedData = [];

        for (final item in data) {
          final orderDate = item['order_date'];
          final deliveryDate = item['delivery_date'];
          final totalBill = item['total_bill'];
          final orderStatus = item['order_status'];
          final groceryStoreId = item['groceryStoreStoreId'];

          if (groceryStoreId != null) {
            print('Fetching grocery store data for ID: $groceryStoreId');

            final groceryStoreResponse = await http.get(
              Uri.parse('http://10.0.2.2:3000/api/grocery_store/$groceryStoreId'),
            );

            if (groceryStoreResponse.statusCode == 200) {
              final Map<String, dynamic> groceryStoreData = jsonDecode(groceryStoreResponse.body);

              final groceryStoreName = groceryStoreData['store_name'];
              final groceryStoreImage = groceryStoreData['image'];

              combinedData.add({
                'order_date': orderDate,
                'delivery_date': deliveryDate,
                'total_bill': totalBill,
                'order_status': orderStatus,
                'grocery_store_store_id': groceryStoreId,
                'store_name': groceryStoreName,
                'image': groceryStoreImage,
              });
            } else {
              print('Failed to load additional grocery store information: ${groceryStoreResponse.statusCode}');
            }
          } else {
            print('grocery_store_store_id is null. Skipping fetching grocery store data.');
          }
        }

        print(combinedData);

        return combinedData;
      } else {
        print('Failed to load orders: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 70),
          child: Text('Current Orders'),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchAndDisplayCombinedData(vendorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No current orders available.'));
            } else {

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final orderData = snapshot.data![index];

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(

                        backgroundImage: AssetImage(orderData['image']),
                        radius: 30,
                      ),
                      title: Text(
                        '${orderData['store_name']}',
                        style: TextStyle(
                          fontSize: 20, // Increase the font size for the title
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to black
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Text(
                            'Delivery Date: ${orderData['delivery_date']}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Order Date: ${orderData['order_date']}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(height: 10),

                          Text(
                            'Total Bill: Rs.${orderData['total_bill']}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              if (orderData['order_status'].toLowerCase() == 'on its way')
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.pin_drop, color: Colors.blueAccent),
                                ),
                              if (orderData['order_status'].toLowerCase() == 'in process')
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.recycling, color: Colors.red),
                                ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                    ),
                                    child: Text(
                                      'Order Status: \n${orderData['order_status']}',
                                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
