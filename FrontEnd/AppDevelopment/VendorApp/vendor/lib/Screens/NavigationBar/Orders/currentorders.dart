import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../../Classes/api.dart';

class CurrentOrdersPage extends StatefulWidget {
  final int vendorId;

  CurrentOrdersPage(this.vendorId);

  @override
  _CurrentOrdersPageState createState() => _CurrentOrdersPageState();
}

class _CurrentOrdersPageState extends State<CurrentOrdersPage> {
  late Future<List<Map<String, dynamic>>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _fetchAndDisplayCombinedData(widget.vendorId);
  }

  Future<List<Map<String, dynamic>>> _fetchAndDisplayCombinedData(int vendorId) async {

    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/order/search/$vendorId'),
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
          final orderId = item['order_id']; // Assuming order_id is included in the response

          if (groceryStoreId != null) {
            print('Fetching grocery store data for ID: $groceryStoreId');

            final groceryStoreResponse = await http.get(
              Uri.parse('${ApiConstants.baseUrl}/api/grocery_store/$groceryStoreId'),
            );

            if (groceryStoreResponse.statusCode == 200) {
              final Map<String, dynamic> groceryStoreData = jsonDecode(groceryStoreResponse.body);

              final groceryStoreName = groceryStoreData['store_name'];
              final groceryStoreImage = groceryStoreData['image'];

              combinedData.add({
                'order_id': orderId,
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

  Future<void> _updateOrderStatus(int orderId, String status) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/api/order/$orderId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'order_status': status}),
      );

      if (response.statusCode == 200) {
        print('Order status updated successfully.');
        setState(() {
          _ordersFuture = _fetchAndDisplayCombinedData(widget.vendorId);
        });
      } else {
        print('Failed to update order status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9100),
        title: Padding(
          padding: const EdgeInsets.only(left: 35),
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
          future: _ordersFuture,
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

                  // Format date strings
                  final orderDateFormatted = DateFormat('dd/MM/yyyy').format(DateTime.parse(orderData['order_date']));
                  final deliveryDateFormatted = DateFormat('dd/MM/yyyy').format(DateTime.parse(orderData['delivery_date']));

                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("${ApiConstants.baseUrl}/api/image/" + orderData['image']),
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
                            'Delivery Date: $deliveryDateFormatted',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            'Order Date: $orderDateFormatted',
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
                                  child: DropdownButton<String>(
                                    value: orderData['order_status'],
                                    items: ['In Process', 'On Its Way', 'Delivered']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          orderData['order_status'] = newValue;
                                        });
                                        _updateOrderStatus(orderData['order_id'], newValue);
                                      }
                                    },
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
