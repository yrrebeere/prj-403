import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';
import 'package:provider/provider.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';

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
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: languageProvider.selectedLocale,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: child!,
          );
        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF6FB457),
            title: Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Text(  AppLocalizations.of(context)!.app_name),
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
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
                              child:
                                  Center(child: Text(' ${widget.storeName}')),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Lake City',
                              style: TextStyle(color: Colors.grey.shade400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Container(
                          height: 250,
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Current Orders',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Items',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Bread',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Bread',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Bread',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Quantity',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'x3',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'x12',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'x2',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Price',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'PKR 520',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'PKR 200',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'PKR 238',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total Bill:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('PKR 958')
                                    ],
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 250,
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
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order History',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Order Date',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                '1/12/23',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                '04/01/24',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                '16/02/24',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'Total Bill:',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'PKR 520',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'PKR 200',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 25,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                'PKR 238',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
