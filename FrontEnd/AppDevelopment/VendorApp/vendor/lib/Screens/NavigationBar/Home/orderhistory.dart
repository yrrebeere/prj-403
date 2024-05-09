import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderHistoryPage extends StatelessWidget {
  final int vendorId;

  OrderHistoryPage(this.vendorId);

  Future<List<Map<String, dynamic>>> _fetchAndDisplayCombinedData(
      int vendorId) async {
    try {
      final response = await http.get(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/order/orderhistory/$vendorId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Map<String, dynamic>> combinedData = [];

        for (final item in data) {
          final orderDate = item['order_date'];
          final deliveryDate = item['delivery_date'];
          final totalBill = item['total_bill'];
          final orderStatus = item['order_status'];
          final groceryStoreId =
              item['groceryStoreStoreId']; // Corrected field name

          if (groceryStoreId != null) {
            print('Fetching grocery store data for ID: $groceryStoreId');

            final groceryStoreResponse = await http.get(
              Uri.parse(
                  'https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/$groceryStoreId'),
            );

            if (groceryStoreResponse.statusCode == 200) {
              final Map<String, dynamic> groceryStoreData =
                  jsonDecode(groceryStoreResponse.body);

              final groceryStoreName = groceryStoreData[
                  'store_name']; // Update the key to 'store_name'
              final groceryStoreImage = groceryStoreData['image'];

              // Combine data
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
              print(
                  'Failed to load additional grocery store information: ${groceryStoreResponse.statusCode}');
            }
          } else {
            print(
                'grocery_store_store_id is null. Skipping fetching grocery store data.');
          }
        }

        // Print the combined data for debugging
        print(combinedData);

        // Return the combined data
        return combinedData;
      } else {
        print('Failed to load orders: ${response.statusCode}');
        return []; // Return an empty list if there's an error
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list if there's an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFF9100),
          title: Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Text('Order History'),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _fetchAndDisplayCombinedData(vendorId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              print('Snapshot data: ${snapshot.data}');
              List<Map<String, dynamic>> combinedData = snapshot.data ?? [];

              return Column(
                children: [
                  SizedBox(height: 20), // Add space at the top
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: combinedData.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, dynamic> data = entry.value;

                        // Check if the order is delivered
                        bool isDelivered = data['order_status'] == 'Delivered';

                        return Card(
                          elevation: 10,
                          margin: EdgeInsets.fromLTRB(
                            index == 0 ? 16 : 8,
                            8,
                            8,
                            8,
                          ),
                          child: Container(
                            height: 500,
                            width: 300,
                            padding: EdgeInsets.all(26),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage("https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+data['image']),
                                ),
                                SizedBox(height: 25),
                                Text(
                                  '${data['store_name']}',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Order Date: ${data['order_date']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Delivery Date: ${data['delivery_date']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Total Bill: Rs.${data['total_bill']}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 25),
                                isDelivered
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 40,
                                      )
                                    : SizedBox(),
                                // No checkmark for non-delivered orders
                                SizedBox(height: 5),
                                Text(
                                  'Order Status: ${data['order_status']}',
                                  style: TextStyle(
                                    color: isDelivered ? Colors.green : null,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20), // Add space at the bottom
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
