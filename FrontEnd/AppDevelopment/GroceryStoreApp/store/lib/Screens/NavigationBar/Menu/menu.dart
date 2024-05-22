import 'package:flutter/material.dart';
import 'package:store/Screens/NavigationBar/Menu/viewprofile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:store/Screens/SelectLanguage/language.dart';
import 'vendorlist.dart';
import '../../SelectLanguage/languageprovider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VendorIdManager {
  static int? vendorId;

  static void logout() {
    vendorId = null;
  }
}

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String name = ""; // Initial values for demonstration
  String number = "";
  String userId = '2'; // Replace with the actual user ID
  String? image;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchStoreProfile("2");
  }

  Future<void> fetchStoreProfile(String storeId) async {
    try {
      final response = await http.get(Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/grocery_store/$storeId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        setState(() {
          image = data['image'].toString().trim();
          isLoading = false;
        });
      } else {
        print('Failed to fetch store information. Status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error during HTTP request: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchUserInfo() async {
    String userId = '2'; // Replace with the actual user ID
    try {
      // Replace 'YOUR_API_ENDPOINT' with the actual API endpoint for fetching user information
      final response = await http.get(Uri.parse('https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Phone Number Type: ${data['phone_number'].runtimeType}');
        // Update user information based on the response
        setState(() {
          name = data['name'];
          number = data['phone_number'].toString().trim(); // Trim leading/trailing whitespaces
        });
      } else {
        // Handle error response
        print('Failed to fetch user information. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error during HTTP request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

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
              body: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                child: Container(
                  color: Color(0xfff2f2f6),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 1000,
                          width: 365,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      'https://sea-lion-app-wbl8m.ondigitalocean.app/api/image/' + image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Container(), // Or any other placeholder widget
                                ),
                              ),
                              Text(name, style: TextStyle(fontSize: 20)),
                              Text('0$number',
                                  style: TextStyle(
                                      fontSize: 17, color: Color(0xFF6FB457))),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewProfile(userId: userId,),
                                    ),
                                  );

                                  if (result != null) {
                                    setState(() {
                                      name = result['name'];
                                      number = result['number'];
                                    });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF6FB457),
                                          borderRadius:
                                          BorderRadius.circular(100),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!.view_profile,
                                        style: TextStyle(fontSize: 20,),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          color: Colors.black, size: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(AppLocalizations.of(context)!.other,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.grey)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.format_list_bulleted_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.vendor_list,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VendorList(),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                          size: 20,
                                        )),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(AppLocalizations.of(context)!.general_settings,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.grey)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.help,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.about,                                    style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.privacy_policy,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.language,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.change_address,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.change_phone_number,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    VendorIdManager.logout();

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Language()),
                                    );
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.logout,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrangeAccent,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
