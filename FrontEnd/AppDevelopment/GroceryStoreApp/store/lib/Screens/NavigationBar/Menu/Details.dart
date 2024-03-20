import 'package:flutter/material.dart';
import 'vendorlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetails {
  final int detailId;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final int orderOrderId; // Assuming this represents the order ID associated with the order details

  OrderDetails({
    required this.detailId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.orderOrderId,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      detailId: json['detail_id'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'].toDouble(),
      totalPrice: json['total_price'].toDouble(),
      orderOrderId: json['orderOrderId'],
    );
  }
}

class Details extends StatefulWidget {
  final Vendor vendor;

  Details({required this.vendor});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<OrderDetails> _orderDetailsList = [];

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/api/order_detail/allorderdetails/'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);

        setState(() {
          _orderDetailsList =
              jsonList.map((item) => OrderDetails.fromJson(item)).toList();
        });
      } else {
        print('Failed to load order details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching order details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text(AppLocalizations.of(context)!.app_name),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                ' ${widget.vendor.vendorName}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),
            Center(
              child: Text(
                'Store Address: ${widget.vendor.deliveryLocations}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),
            if (_orderDetailsList.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: _orderDetailsList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                    var orderDetails = _orderDetailsList[index];
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          'Item ID: ${orderDetails.detailId}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${orderDetails.quantity}', style: TextStyle(fontSize: 16)),
                            Text('Unit Price: ${orderDetails.unitPrice}', style: TextStyle(fontSize: 16)),
                            Text('Total Price: ${orderDetails.totalPrice}', style: TextStyle(fontSize: 16)),
                            Text('Order ID: ${orderDetails.orderOrderId}', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (_orderDetailsList.isEmpty)
              Text(
                'No order details available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
