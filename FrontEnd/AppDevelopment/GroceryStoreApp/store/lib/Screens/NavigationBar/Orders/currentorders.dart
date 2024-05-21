import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CurrentOrdersPage extends StatelessWidget {
  final int vendorId;

  CurrentOrdersPage(this.vendorId);

  Future<List<Map<String, dynamic>>> _fetchAndDisplayCombinedData(int storeId) async {

    storeId = 2;

    try {
      final response = await http.get(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/order/storecurrentorder/$storeId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> orders = responseData['orders'];
        final List<dynamic> orderDetails = responseData['orderDetails'];
        final List<dynamic> productInventories = responseData['productInventories'];
        final List<dynamic> products = responseData['products'];

        List<Map<String, dynamic>> combinedData = [];

        for (final order in orders) {
          final orderId = order['order_id'];

          // Filter order details for the current order
          List<Map<String, dynamic>> detailsForOrder = [];
          for (final detail in orderDetails) {
            if (detail['order_order_id'] == orderId) {
              // Find the product inventory details based on product_inventory_id
              final productInventory = productInventories.firstWhere((inventory) => inventory['product_inventory_id'] == detail['product_inventory_product_inventory_id'], orElse: () => null);

              if (productInventory != null) {
                // Find the product details based on product_id
                final product = products.firstWhere((product) => product['product_id'] == productInventory['product_product_id'], orElse: () => null);

                if (product != null) {
                  detailsForOrder.add({
                    'product_name': product['product_name'],
                    'unit_price': detail['unit_price'],
                    'quantity': detail['quantity'],
                    'order_id': detail['order_order_id']
                  });
                }
              }
            }
          }

          final orderDate = order['order_date'];
          final deliveryDate = order['delivery_date'];
          final totalBill = order['total_bill'];
          final orderStatus = order['order_status'];
          final groceryStoreId = order['groceryStoreStoreId'];
          final vendorId = order['vendorVendorId'];

          if (vendorId != null) {
            final vendorResponse = await http.get(
              Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/vendor/$vendorId'),
            );

            if (vendorResponse.statusCode == 200) {
              final Map<String, dynamic> vendorData = jsonDecode(vendorResponse.body);
              final vendorName = vendorData['vendor_name'];
              final vendorImage = vendorData['image'];

              combinedData.add({
                'order_id': orderId,
                'order_date': orderDate,
                'delivery_date': deliveryDate,
                'total_bill': totalBill,
                'order_status': orderStatus,
                'grocery_store_store_id': groceryStoreId,
                'vendor_name': vendorName,
                'image': vendorImage,
                'order_details': detailsForOrder,
              });
            } else {
              print('Failed to load additional vendor information: ${vendorResponse.statusCode}');
            }
          } else {
            print('grocery_store_store_id is null. Skipping fetching grocery store data.');
          }
        }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
                  'Current Orders',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6FB457),
                  ),
                )
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchAndDisplayCombinedData(vendorId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No current orders available.'));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final orderData = snapshot.data![index];

                        // Parse delivery_date and order_date
                        DateTime deliveryDate = DateTime.parse(orderData['delivery_date']);
                        DateTime orderDate = DateTime.parse(orderData['order_date']);

                        // Format dates using DateFormat
                        String formattedDeliveryDate = DateFormat('dd-MM-yyyy').format(deliveryDate);
                        String formattedOrderDate = DateFormat('dd-MM-yyyy').format(orderDate);

                        // Filter order details based on order_id of the current order
                        List<Map<String, dynamic>> filteredOrderDetails = orderData['order_details']
                            .where((detail) => detail['order_id'] == orderData['order_id'])
                            .toList();

                        print(orderData);

                        return Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage("https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/" + orderData['image']),
                              radius: 40,
                            ),
                            title: Text(
                              '${orderData['vendor_name']}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6FB457),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Text(
                                  'Delivery Date: $formattedDeliveryDate', // Display formatted delivery_date
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                Text(
                                  'Order Date: $formattedOrderDate', // Display formatted order_date
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                                SizedBox(height: 12),
                                // Display filtered order details in a table
                                Table(
                                  columnWidths: {
                                    0: FlexColumnWidth(1), // Product ID
                                    1: FlexColumnWidth(1), // Unit Price
                                    2: FlexColumnWidth(1), // Quantity
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Text('Product', style: TextStyle(fontWeight: FontWeight.bold)),
                                        )),
                                        TableCell(child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold)),
                                        )),
                                        TableCell(child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                                        )),
                                      ],
                                    ),
                                    // Generate rows for filtered order details
                                    ...filteredOrderDetails.map<TableRow>((detail) {
                                      final productName = detail['product_name'];
                                      final unitPrice = detail['unit_price'];
                                      final quantity = detail['quantity'];

                                      return TableRow(
                                        children: [
                                          TableCell(child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Text(productName.toString()),
                                          )),
                                          TableCell(child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Text('$unitPrice'),
                                          )),
                                          TableCell(child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Text(quantity.toString()),
                                          )),
                                        ],
                                      );
                                    }).toList(),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Total Bill: Rs.${orderData['total_bill']}',
                                  style: TextStyle(fontSize: 19, color: Colors.black),
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
                                            color: Color(0xFF6FB457),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            '${orderData['order_status']}',
                                            style: TextStyle(fontSize: 20, color: Colors.white),
                                            textAlign: TextAlign.center,
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
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
