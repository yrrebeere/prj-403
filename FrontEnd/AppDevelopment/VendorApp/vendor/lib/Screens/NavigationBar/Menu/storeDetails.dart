import 'package:flutter/material.dart';

class StoreDetails extends StatefulWidget {
  final String storeName;

  StoreDetails({required this.storeName});

  @override
  _StoreDetailsState createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails> {
  // Commented out the imageUrl variable
  // String imageUrl = "https://example.com/default_image.jpg"; // Replace with your default image URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text('WASAIL'),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 650,
              width: 370,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        // Commented out the imageUrl from the NetworkImage
                        // image: DecorationImage(
                        //   image: NetworkImage(imageUrl),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      ' ${widget.storeName}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Current Orders',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // TODO: Add widget to display current orders
                    SizedBox(height: 20),
                    Text(
                      'Order History',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // TODO: Add widget to display order history
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
