import 'package:flutter/material.dart';
import 'storelist.dart';
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
  final Store store;

  Details({required this.store});

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Store Name: ${widget.store.storeName}'),
          Text('Store Address: ${widget.store.storeAddress}'),
          if (_orderDetailsList.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _orderDetailsList.length,
                itemBuilder: (context, index) {
                  var orderDetails = _orderDetailsList[index];
                  return Card(
                    child: ListTile(
                      title: Text('Item ID: ${orderDetails.detailId}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantity: ${orderDetails.quantity}'),
                          Text('Unit Price: ${orderDetails.unitPrice}'),
                          Text('Total Price: ${orderDetails.totalPrice}'),
                          Text('Order ID: ${orderDetails.orderOrderId}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          if (_orderDetailsList.isEmpty)
            Text('No order details available'),
        ],
      ),
    );
  }
}
