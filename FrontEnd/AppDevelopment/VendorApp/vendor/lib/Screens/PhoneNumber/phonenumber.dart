import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Login/login.dart';
import '../Registration/registration.dart';
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

  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    final String url = "http://10.0.2.2:3000/api/user_table/checkPhoneNumber/$phoneNumber";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      final dynamic json = jsonDecode(response.body);
      bool phoneNumberExists = json;

      return phoneNumberExists;
    } catch (e) {
      print("Error checking phone number existence: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),

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
                  left: screenWidth * 0.39,
                  top: screenHeight * 0.01,
                  child: Text(
                    AppLocalizations.of(context)!.app_name,
                    style: TextStyle(
                      color: Color(0xFF6FB457),
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
                  left: screenWidth * 0.43,
                  top: screenHeight * 0.28,
                  child: Image.asset(
                    'assets/images/mobile_icon.png',
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                  ),
                ),
                SizedBox(height: 15),
                Positioned(
                  left: screenWidth * 0.11,
                  top: screenHeight * 0.4,
                  child: Container(
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
                            "assets/images/pakistan.png",
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
                                .map<DropdownMenuItem<String>>((String value) {
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
                          child: TextField(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.35,
                  top: screenHeight * 0.76,
                  child: GestureDetector(
                    onTap: () async {
                      print("Register button tapped");
                      String phoneNumber = phoneNumberController.text;

                      // Check if the phone number exists in the database
                      bool phoneNumberExists = await checkPhoneNumberExists(phoneNumber);

                      print("Phone Number Exists: $phoneNumberExists");

                      // Navigate accordingly
                      if (phoneNumberExists) {
                        print("Navigating to Login");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(phoneNumber: phoneNumber),
                          ),
                        );
                      } else {
                        print("Navigating to Registration");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(phoneNumberController: phoneNumberController),
                          ),
                        );
                      }
                    },

                    child: Container(
                      width: screenWidth * 0.3,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF6FB457),
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
}
