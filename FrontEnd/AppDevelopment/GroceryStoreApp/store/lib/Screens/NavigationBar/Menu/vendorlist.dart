import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Details.dart';

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
  final String image;

  Vendor({
    required this.vendorName,
    required this.deliveryLocations,
    required this.userId,
    required this.image,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      vendorName: json['vendor_name'],
      deliveryLocations: json['delivery_locations'],
      userId: json['user_table_user_id'],
      image: json['image'],
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
            'https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/viewvendorlist/$vendorId'),
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
        backgroundColor: Colors.transparent, // Make app bar transparent
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(0xFF6FB457)
          ),
        ),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: EdgeInsets.all(8.0), // Add padding to the container
                  decoration: BoxDecoration(
                    color: Color(0xFF6FB457), // Background color of the container
                    borderRadius: BorderRadius.circular(8), // Border radius of the container
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.vendor_list,
                      style: TextStyle(fontSize: 20, color: Colors.white), // Text color set to white
                    ),
                  ),
                ),
              ),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _vendorList.length,
                itemBuilder: (context, index) {
                  return buildStoreCard(_vendorList[index]);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),

    );
  }
  Widget buildStoreCard(Vendor vendor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(vendor: vendor),
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
                  ),
                  child: Image.network(
                    "https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/"+vendor.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
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
                      vendor.vendorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      vendor.deliveryLocations,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                icon: Icon(Icons.delete), color: Colors.red,
                onPressed: () {
                  _deleteVendor(vendor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteVendor(Vendor vendor) async {
    try {

      final response = await http.delete(
        Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/list/1'),
      );

      // Update the local list after successful deletion from the database
      setState(() {
        _vendorList.remove(vendor);
      });
    } catch (e) {
      print('Error deleting vendor: $e');
    }
  }

}


