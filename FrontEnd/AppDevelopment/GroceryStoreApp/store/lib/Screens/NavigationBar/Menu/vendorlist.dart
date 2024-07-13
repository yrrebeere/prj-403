import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:store/Screens/NavigationBar/Home/vendordetails.dart';
import 'dart:convert';
import '../../../Classes/api.dart';
import '../../../Classes/vendor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VendorList(),
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
  int storeId = 2;

  @override
  void initState() {
    super.initState();
    _fetchVendorList();
  }

  Future<void> _fetchVendorList() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${ApiConstants.baseUrl}/api/grocery_store/viewvendorlist/$storeId'),
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
                padding: const EdgeInsets.only(top: 18, bottom: 8),
                child: Center(
                    child: Text(
                      'Vendor List',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6FB457),
                      ),
                    )
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
            builder: (context) => VendorDetailsPage(vendorId: vendor.vendorId),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 120,
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
                  height: 90,
                  width: 90,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Image.network(
                    "${ApiConstants.baseUrl}/api/image/"+vendor.image,
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
        Uri.parse('${ApiConstants.baseUrl}/api/list/1'),
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


