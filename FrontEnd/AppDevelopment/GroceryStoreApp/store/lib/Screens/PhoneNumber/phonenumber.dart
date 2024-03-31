import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:store/Screens/OTP/otp.dart';
import '../SelectLanguage/languageprovider.dart';
import '../Login/login.dart';
import '../Registration/registration.dart';
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

  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    final String url = "http://10.0.2.2:3000/api/user_table/numberExists/$phoneNumber";

    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );

      final dynamic json = jsonDecode(response.body);
      bool phoneNumberExists = json['exists'];

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
              title: Text(AppLocalizations.of(mainContext)!.number_confirmation,   style: TextStyle( color: Colors.orangeAccent),),
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
                  child: Text(AppLocalizations.of(mainContext)!.edit,   style: TextStyle( color: Colors.orangeAccent),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(mainContext)!.confirm,   style: TextStyle( color: Colors.orangeAccent),),
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

    print("Phone Number Exists: $phoneNumberExists");
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
              body: SafeArea(
                child: Container(
                  width: screenWidth * 1,
                  height: screenHeight * 1,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: GiantCirclePainter(),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.12,
                        top: screenHeight * 0.02,
                        child: IconButton(
                          onPressed: () {
                            // Add your help functionality here
                          },
                          icon: Icon(
                            Icons.settings_outlined,
                            color: Color(0xFF6FB457),
                            size: 28,
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.03,
                        top: screenHeight * 0.02,
                        child: IconButton(
                          onPressed: () {
                            // Add your help functionality here
                          },
                          icon: Icon(
                            Icons.settings_power_outlined,
                            color: Color(0xFF6FB457),
                            size: 28,
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.42,
                        top: screenHeight * 0.23,
                        child: IconButton(
                          onPressed: () {
                            // Add your help functionality here
                          },
                          icon: Icon(
                            Icons.add_ic_call_outlined,
                            color: Colors.orangeAccent,
                            size: 30,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.4,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.2,
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
                        top: screenHeight * 0.04,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.chevron_left_outlined,
                                    size: screenWidth * 0.106, color: Colors.white),
                                SizedBox(
                                  width: screenWidth * 0.012,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.38,
                        top: screenHeight * 0.1,
                        child: Text(
                          AppLocalizations.of(context)!.app_name,
                          style: TextStyle(
                            color: Color(0xFF6FB457),
                            fontSize: 32,
                            fontFamily: 'Inter',
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.22,
                        top: screenHeight * 0.2,
                        child: Text(
                          AppLocalizations.of(context)!.enter_number,
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: screenWidth * 0.06,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.32,
                        top: screenHeight * 0.3,
                        child: Image.asset(
                          'Assets/Images/mobile_icon.png',
                          width: screenWidth * 0.4,
                          height: screenWidth * 0.4,
                        ),
                      ),
                      SizedBox(height: 15),
                      Positioned(
                        left: screenWidth * 0.11,
                        top: screenHeight * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.07,
                              decoration: BoxDecoration(
                                color: Colors.white,

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
                        left: screenWidth * 0.37,
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
                              color:Colors.orangeAccent,
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

class GiantCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint darkPaint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFF6FB457), Color(0xFF7B1FA2), Colors.orangeAccent],
        stops: [0.0, 0.6, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width * 0.8))
      ..style = PaintingStyle.fill;

    Paint lightPaint = Paint()
      ..shader = LinearGradient(
        colors: [Color(0xFFD05CE3), Color(0xFFF8BBD0), Colors.orange],
        stops: [0.0, 0.6, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width * 0.4))
      ..style = PaintingStyle.fill;

    double circleRadius = size.width * 1; // Reduce size

    canvas.drawCircle(
        Offset(-circleRadius / 2, -circleRadius / 2), circleRadius, darkPaint);
    canvas.drawCircle(
        Offset(size.width + circleRadius / 2, size.height + circleRadius / 2),
        circleRadius,
        darkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}