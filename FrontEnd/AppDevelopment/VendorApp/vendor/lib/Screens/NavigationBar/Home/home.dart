import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';
import 'package:provider/provider.dart';
import '../../SelectLanguage/languageprovider.dart';
import '../../Login/login.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class searchProductInventory {
  final int productId;
  final String name;
  final String imageUrl;

  searchProductInventory({
    required this.productId,
    required this.name,
    required this.imageUrl,
  });

  factory searchProductInventory.fromJson(Map<String, dynamic> json) {
    return searchProductInventory(
      productId: json['product_id'],
      name: json['product_name'],
      imageUrl: json['image'],
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<searchProductInventory> searchResults = [];
  TextEditingController searchController = TextEditingController();

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
          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xfff2f2f6),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: AppLocalizations.of(context)!.search,
                            ),
                            textDirection:
                                TextDirection.ltr, // Set textDirection to LTR
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {
                            String query = searchController.text;
                            await _searchProductById(query);
                          },
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 160,
                      width: 380,
                      decoration: BoxDecoration(
                        color: Color(0xFF141022),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.you_have,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '15',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.orders_today,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<void> _searchProductById(String query) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:3000/api/search/$query'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        searchResults =
            data.map((item) => searchProductInventory.fromJson(item)).toList();
      });
    } else {
      print('Failed to load products');
    }
  }
}
