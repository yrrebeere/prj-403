import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/Screens/Login/resetpassword.dart';
import 'package:vendor/Screens/NavigationBar/navbar.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../PhoneNumber/phonenumberprovider.dart';
import '../Registration/registrationprovider.dart';
import '../SelectLanguage/languageprovider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  final String phoneNumber;
  final int? userId;

  const Login({Key? key, required this.phoneNumber, this.userId}) : super(key: key);

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _attemptLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String password = passwordController.text;
      String phoneNumber = widget.phoneNumber;

      final url = 'https://sea-lion-app-wbl8m.ondigitalocean.app/api/user_table/passwordchecker/$phoneNumber/$password';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {

          // Password is correct, navigate to the next page (e.g., NavBar)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavBar()),
          );
        } else {
          // Password is incorrect, show error message
          _showErrorDialog(context, 'Incorrect password. Please try again.');
        }
      } catch (e) {
        print('Error: $e');
        // Handle error if the HTTP request fails
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.userId != null) {
      // Handle the user ID, for example, store it in a provider
      final userIdProvider = Provider.of<UserIdProvider>(context, listen: false);
      userIdProvider.setUserId(widget.userId); // Convert int to String
    }

    Future.delayed(Duration.zero, () {
      Provider.of<PhoneNumberProvider>(context, listen: false)
          .setPhoneNumber(widget.phoneNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: SafeArea(
            child: Builder(
              builder: (BuildContext builderContext) {
                return Form(
                  key: _formKey,
                  child: Container(
                    width: screenWidth * 1,
                    height: screenHeight * 1,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Colors.white),
                    child: SingleChildScrollView(
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
                              width: screenWidth * 1.0,
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
                            left: screenWidth * 0.07,
                            top: screenHeight * 0.33,
                            child: Text(
                              AppLocalizations.of(context)!.phone_number,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.34,
                            top: screenHeight * 0.01,
                            child: Center(
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
                          ),
                          Positioned(
                            left: screenWidth * 0.07,
                            top: screenHeight * 0.2,
                            child: Text(
                              AppLocalizations.of(context)!.login,
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
                                        size: screenWidth * 0.106,
                                        color: Colors.black),
                                    SizedBox(
                                      width: screenWidth * 0.012,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: screenWidth * 0.10,
                            top: screenHeight * 0.39,
                            child: Container(
                              width: screenWidth * 0.800,
                              height: screenHeight * 0.06,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: Colors.teal,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                            '0${widget.phoneNumber}',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.040,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              color: Colors.teal,
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: screenHeight * 0.10),
                              child: SizedBox(
                                  width: screenWidth * 0.800,
                                  height: screenHeight * 0.06,
                                  child: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.teal),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.teal),
                                        ),
                                        filled: true,
                                        prefixIcon: Icon(Icons.lock,
                                            color: Colors.teal, size: 25),
                                        hintText: AppLocalizations.of(context)!
                                            .enter_password,
                                        suffixStyle: TextStyle(
                                          fontSize: screenWidth * 0.040,
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.teal),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password is required';
                                        } else if (value.length < 8) {
                                          return 'Password should be at least 8 digits long';
                                        } else if (!RegExp(
                                                r'[!@#$%^&*(),.?":{}|<>]')
                                            .hasMatch(value)) {
                                          return 'Password should contain at least one special character';
                                        }
                                        return null;
                                      },
                                    ),
                                  )),
                            ),
                          ),

                          // Positioned(
                          //   left: screenWidth * 0.4,
                          //   top: screenHeight * 0.798,
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       FocusScope.of(context).unfocus();
                          //       if (_formKey.currentState!.validate()) {
                          //         String password = passwordController.text;
                          //         Navigator.push(
                          //           builderContext,
                          //           MaterialPageRoute(
                          //             builder: (context) => NavBar(),
                          //           ),
                          //         );
                          //       }
                          //     },
                          //     child: Container(
                          //       width: screenWidth * 0.2,
                          //       decoration: BoxDecoration(
                          //         color: const Color(0xFF007AFF),
                          //         borderRadius: BorderRadius.circular(
                          //             screenHeight * 0.03),
                          //       ),
                          //       child: Container(
                          //         padding: const EdgeInsets.all(16.0),
                          //         decoration: BoxDecoration(
                          //           color: Color(0xFFFF9100),
                          //           borderRadius: BorderRadius.circular(8.0),
                          //         ),
                          //         child: Center(
                          //           child: Text(
                          //             AppLocalizations.of(context)!.login,
                          //             style: TextStyle(color: Colors.white),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            left: screenWidth * 0.4,
                            top: screenHeight * 0.68,
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                _attemptLogin(context); // Call the login attempt function
                              },
                              child: Container(
                                width: screenWidth * 0.2,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF007AFF),
                                  borderRadius: BorderRadius.circular(screenHeight * 0.03),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF6FB457),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
