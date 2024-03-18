import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VendorList(),
    );
  }
}

class Vendor {
  final String vendorName;
  final String deliveryLocations;
  final int userId;

  Vendor({
    required this.vendorName,
    required this.deliveryLocations,
    required this.userId,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorName: json['vendor_name'],
      deliveryLocations: json['delivery_locations'],
      userId: json['user_table_user_id'],
    );
  }
}

class VendorList extends StatefulWidget {
  const VendorList({Key? key});

  @override
  State<VendorList> createState() => _VendorListState();
}

class _VendorListState extends State<VendorList> {
  List<Vendor> _vendorList = [];
  int vendorId = 1;

  @override
  void initState() {
    super.initState();
    _fetchVendorList();
  }

  Future<void> _fetchVendorList() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://10.0.2.2:3000/api/grocery_store/viewvendorlist/$vendorId'),
      );

      if (response.statusCode == 200) {
        // print(response.body);
        final List<dynamic> jsonList = jsonDecode(response.body);

        setState(() {
          _vendorList = jsonList.map((item) => Vendor.fromJson(item)).toList();
          print(_vendorList);
        });
      } else {
        print('Failed to load vendor list: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching vendor list: $e');
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
      body: ListView.builder(
        itemCount: _vendorList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_vendorList[index].vendorName),
            subtitle: Text(_vendorList[index].deliveryLocations),
            onTap: () {
              // Handle tapping on a vendor item if needed
            },
          );
        },
      ),
    );
  }
}


