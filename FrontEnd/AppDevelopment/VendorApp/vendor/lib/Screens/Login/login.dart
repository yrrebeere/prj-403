import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../OTP/otp.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  final String phoneNumber;

  const Login({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('ur', 'en'),
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
                        left: screenWidth * 0.36,
                        top: screenHeight * 0.01,
                        child: Center(
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
                        left: screenWidth * 0.07,
                        top: screenHeight * 0.46,
                        child: Text(
                          AppLocalizations.of(context)!.password,
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
                        left: screenWidth * 0.07,
                        top: screenHeight * 0.6,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.reset,
                                style: TextStyle(
                                  color: const Color(0xFF007AFF),
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: ' ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  height: 0,
                                ),
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!.password,
                                style: TextStyle(
                                  color: const Color(0xFF007AFF),
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.10,
                        top: screenHeight * 0.387,
                        child: Container(
                          width: screenWidth * 0.800,
                          height: screenHeight * 0.06,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.teal,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '0${widget.phoneNumber}',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.teal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.1, top: screenHeight * 0.52),
                        child: SizedBox(
                          width: screenWidth * 0.800,
                          height: screenHeight * 0.06,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal),
                              ),
                              filled: true,
                              prefixIcon: Icon(Icons.lock, color: Colors.teal, size: 25),
                              hintText: AppLocalizations.of(context)!.enter_password,
                              suffixStyle: TextStyle(fontSize: 25),
                              hintStyle: TextStyle(color: Colors.teal),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 8) {
                                return 'Password should be at least 8 digits long';
                              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                                return 'Password should contain at least one special character';
                              }
                              return null; // Return null if the password is valid
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.4,
                        top: screenHeight * 0.798,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              String password = passwordController.text;
                              Navigator.push(
                                builderContext,
                                MaterialPageRoute(
                                  builder: (context) => OTP(
                                    password: password,
                                    phoneNumber: widget.phoneNumber,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(screenHeight * 0.03),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child:  Text(
                                  AppLocalizations.of(context)!.login,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
