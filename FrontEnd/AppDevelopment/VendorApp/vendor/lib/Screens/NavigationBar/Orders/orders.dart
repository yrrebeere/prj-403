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
                  child: Text(
                    'Current Orders',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Container(
              height: 350,
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
                child:Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:  Center(child: Text('Jalal Sons')),
                              ),
                              SizedBox(height: 10,),
                              Text('Lake City',style: TextStyle(color: Colors.grey.shade400),),
                            ],
                          ),
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(bottom: 10.0),
                        //       child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                        //     ),
                        //   ],
                        // ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('Items',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('Bread',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('Bread',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('Bread',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('Quantity',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('x3',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('x12',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('x2',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 30,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('Price',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('PKR 520',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('PKR 200',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 25,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: Center(child: Text('PKR 238',style: TextStyle(fontSize: 15,color: Colors.black),)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Total Bill:',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text('PKR 958')
                      ],
                    )
                  ],
                )
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 350,
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
                  child:Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:  Center(child: Text('Jalal Sons')),
                                ),
                                SizedBox(height: 10,),
                                Text('Lake City',style: TextStyle(color: Colors.grey.shade400),),
                              ],
                            ),
                          ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Padding(
                          //       padding: const EdgeInsets.only(bottom: 10.0),
                          //       child: Icon(Icons.arrow_forward_ios, color: Colors.black),
                          //     ),
                          //   ],
                          // ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('Items',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('Bread',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('Bread',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('Bread',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('Quantity',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('x3',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('x12',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('x2',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('Price',style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.bold),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('PKR 520',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('PKR 200',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 25,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(child: Text('PKR 238',style: TextStyle(fontSize: 15,color: Colors.black),)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Total Bill:',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('PKR 958')
                        ],
                      )
                    ],
                  )
              ),
            ),
            SizedBox(height: 20),
          ],
        )
        ,
      )
    );
  }
}
