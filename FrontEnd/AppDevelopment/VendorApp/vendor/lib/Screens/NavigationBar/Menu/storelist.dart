import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';
import 'package:provider/provider.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:vendor/Screens/NavigationBar/Menu/storeDetails.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Storelist(),
    );
  }
}

class Store {
  final String storeName;
  final String image;
  final String storeAddress;

  Store({
    required this.storeName,
    required this.image,
    required this.storeAddress,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeName: json['store_name'],
      image: json['image'],
      storeAddress: json['store_address'],
    );
  }
}

class Storelist extends StatefulWidget {
  const Storelist({super.key});

  @override
  State<Storelist> createState() => _StorelistState();
}

class _StorelistState extends State<Storelist> {
  List<Store> _groceryStoreList = [];
  int vendorId = 1;

  @override
  void initState() {
    super.initState();
    _fetchGroceryStoresList();
  }

  Future<void> _fetchGroceryStoresList() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/api/grocery_store/searchstore/$vendorId'),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      setState(() {
        _groceryStoreList =
            jsonList.map((item) => Store.fromJson(item)).toList();
      });
    } else {
      print('Failed to load grocery store');
    }
  }

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
                child: Icon(Icons.arrow_back_ios),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              color: Color(0xfff2f2f6),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      AppLocalizations.of(context)!.store_list,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  // Use ListView.builder to dynamically build the store list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _groceryStoreList.length,
                    itemBuilder: (context, index) {
                      return buildStoreCard(_groceryStoreList[index]);
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildStoreCard(Store store) {
    return GestureDetector(
      onTap: () {
        // Navigate to StoreDetails page when the store card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoreDetails(storeName: store.storeName),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 160,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  // Add your image widget here based on the store.image
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.storeName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.arrow_forward_ios, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
