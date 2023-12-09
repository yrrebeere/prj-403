import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xfff2f2f6),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text('120 Listed SKUs',style: TextStyle(fontSize: 20),),
                ),
              ],
            ),
            Container(
              height: 160,
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
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text('Olpers 1.5 Ltr',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                          Text('Available Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Listed Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Unit Cost: 450',style: TextStyle(color:  Color(0xFF6FB457)),),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Align icon vertically centered
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0), // Adjust bottom padding as needed
                          child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 160,
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
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text('Olpers 1.5 Ltr',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                          Text('Available Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Listed Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Unit Cost: 450',style: TextStyle(color:  Color(0xFF6FB457)),),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Align icon vertically centered
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0), // Adjust bottom padding as needed
                          child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 160,
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
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text('Olpers 1.5 Ltr',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                          Text('Available Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Listed Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Unit Cost: 450',style: TextStyle(color:  Color(0xFF6FB457)),),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Align icon vertically centered
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0), // Adjust bottom padding as needed
                          child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              height: 160,
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
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                        children: [
                          Text('Olpers 1.5 Ltr',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                          Text('Available Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Listed Qty: 124',style: TextStyle(color: Color(0xFF007AFF)),),
                          Text('Unit Cost: 450',style: TextStyle(color:  Color(0xFF6FB457)),),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Align icon vertically centered
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0), // Adjust bottom padding as needed
                          child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
