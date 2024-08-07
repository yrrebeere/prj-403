import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Classes/api.dart';
import 'package:vendor/Screens/OTP/otp.dart';
import '../../Classes/user_provider.dart';
import '../../Classes/languageprovider.dart';
import '../Login/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _MyAppState();
}

class _MyAppState extends State<PhoneNumber> {
  final TextEditingController phoneNumberController = TextEditingController();
  String selectedCountryCode = '+92';
  String phoneNumberError = '';

  Future<bool> checkIfVendor(String userId) async {

    final String url = "${ApiConstants.baseUrl}/api/user_table/$userId";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      final dynamic json = jsonDecode(response.body);
      String userType = json['user_type'];

      print("User Type: " + userType);

      if (userType == "Vendor") {
        return true;
      }

      else {
        return false;
      }

    } catch (e) {
      print("Error checking if vendor: $e");
      return false;
    }

  }

  Future<String> getUserId(String phoneNumber) async {

    final String url = "${ApiConstants.baseUrl}/api/user_table/numberExists/$phoneNumber";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      final dynamic json = jsonDecode(response.body);
      String userId = json['userId'].toString();

      return userId;

    } catch (e) {
      print("Error checking if user: $e");
      return "";
    }

  }

  Future<String> getVendorByUserId(String userId) async {

    final String url = "${ApiConstants.baseUrl}/api/vendor/getvendor/$userId";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      final dynamic json = jsonDecode(response.body);
      String vendorId = json['vendor_id'].toString();

      return vendorId;

    } catch (e) {
      print("Error checking if user: $e");
      return "";
    }

  }

  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    final String url = "${ApiConstants.baseUrl}/api/user_table/numberExists/$phoneNumber";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      final dynamic json = jsonDecode(response.body);
      bool phoneNumberExists = json['exists'];
      int userId = json['userId'];
      String vendorId = await getVendorByUserId(userId.toString());

      Provider.of<UserProvider>(context, listen: false).setUserId(userId.toString());
      Provider.of<UserProvider>(context, listen: false).setVendorId(vendorId.toString());

      String myUser = Provider.of<UserProvider>(context, listen: false).userId;
      String myVendor = Provider.of<UserProvider>(context, listen: false).vendorId;

      print("My User: " + myUser);
      print("My Vendor: " + myVendor);

      return phoneNumberExists;
    } catch (e) {
      print("Error checking phone number existence: $e");
      return false;
    }
  }

  Future<void> _showConfirmationDialog(BuildContext mainContext, String phoneNumber) async {
    await Future.delayed(Duration(milliseconds: 100));
    return showDialog<void>(
      context: mainContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(mainContext)!.number_confirmation),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(AppLocalizations.of(mainContext)!.confirm_number),
                    Text(
                      '$selectedCountryCode $phoneNumber',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(mainContext)!.edit),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(mainContext)!.confirm),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _handleConfirmation(phoneNumber);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handleConfirmation(String phoneNumber) async {
    bool phoneNumberExists = await checkPhoneNumberExists(phoneNumber);
    String userId = await getUserId(phoneNumber);

    print("Phone Number Exists: $phoneNumberExists");

    if (phoneNumberExists) {
      bool isVendor = await checkIfVendor(userId);

      if (isVendor) {
        print("Navigating to Login");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(phoneNumber: phoneNumber),
          ),
        );
      }

      else {
        // Show dialog if user is not a vendor
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("This is the Vendor App"),
              content: Text(
                "This phone number is registered as a Grocery Store. "
                    "Kindly use the Grocery Store App.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("Okay"),
                ),
              ],
            );
          },
        );
      }

    } else {
      print("Navigating to Registration");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTP(
            phoneNumber: phoneNumberController.text,
            password: '', // Pass any other parameters if needed

          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child)
        {
          print("Selected Locale: ${languageProvider.selectedLocale}");

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
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: SafeArea(
                child: Container(
                  width: screenWidth * 1,
                  height: screenHeight * 1,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.2,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.718,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.023,
                        top: screenHeight * 0.001,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.chevron_left_outlined,
                                    size: screenWidth * 0.106, color: Colors.black),
                                SizedBox(
                                  width: screenWidth * 0.012,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.36,
                        top: screenHeight * 0.01,
                        child: Text(
                          AppLocalizations.of(context)!.app_name,
                          style: TextStyle(
                            color: Color(0xFFFF9100),
                            fontSize: 32,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.2,
                        top: screenHeight * 0.2,
                        child: Text(
                          AppLocalizations.of(context)!.enter_number,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.40,
                        top: screenHeight * 0.28,
                        child: Image.asset(
                          'Assets/Images/mobile_icon.png',
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                        ),
                      ),
                      SizedBox(height: 15),
                      Positioned(
                        left: screenWidth * 0.11,
                        top: screenHeight * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 0,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: screenWidth * 0.07,
                                    child: Image.asset(
                                      "Assets/Images/pakistan.png",
                                      width: screenWidth * 0.07,
                                      height: screenHeight * 0.03,
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.2,
                                    child: DropdownButton<String>(
                                      value: selectedCountryCode,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCountryCode = newValue!;
                                        });
                                      },
                                      underline: Container(),
                                      items: <String>['+92']
                                          .map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 8),
                                              Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.045,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Container(
                                    width: screenWidth * 0.45,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'XXXXXXXXXX',
                                            hintStyle: TextStyle(
                                              fontSize: screenWidth * 0.048,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              phoneNumberError = '';
                                            });
                                            if (value.isNotEmpty &&
                                                !value.startsWith('3')) {
                                              setState(() {
                                                phoneNumberError =
                                                'Phone number must start with 3';
                                              });
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (phoneNumberError.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      phoneNumberError,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: screenWidth * 0.035,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.35,
                        top: screenHeight * 0.76,
                        child: GestureDetector(
                          onTap: () async {
                            print("Register button tapped");
                            String phoneNumber = phoneNumberController.text;
                            if (phoneNumber.length != 10) {
                              setState(() {
                                phoneNumberError =
                                'Phone number must be 10 digits long';
                              });
                              return;
                            }
                            if (!phoneNumber.startsWith('3')) {
                              setState(() {
                                phoneNumberError = 'Phone number must start with 3';
                              });
                              return;
                            }
                            setState(() {
                              phoneNumberError = '';
                            });

                            await _showConfirmationDialog(context, phoneNumber);
                          },
                          child: Container(
                            width: screenWidth * 0.3,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF9100),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.next_button,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}