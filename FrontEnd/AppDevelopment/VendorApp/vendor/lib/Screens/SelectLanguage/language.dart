import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../PhoneNumber/phonenumber.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  static const String routeName = "/page1";
  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      builder: (context, child) {
        // Determine text direction based on selected language
        TextDirection textDirection = selectedLanguage == 'Urdu' ? TextDirection.rtl : TextDirection.ltr;

        return Directionality(
          textDirection: textDirection,
          child: child!,
        );
      },
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
            builder: (BuildContext context) {
              return Container(
                width: screenWidth,
                height: screenHeight,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: screenHeight * 0.1,
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
                      left: screenWidth * 0.38,
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
                      left: screenWidth * 0.3,
                      top: screenHeight * 0.2,
                      child: Text(
                        AppLocalizations.of(context)!.select_lang,
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.35,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = 'English';
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'English'
                                ? Colors.blueAccent
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'EN                         English',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.048,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.45,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = 'Urdu';
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'Urdu'
                                ? Colors.blueAccent
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'UR                             Urdu',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.048,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.55,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = 'Arabic';
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'Arabic'
                                ? Colors.blueAccent
                                : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'اردو                                اب',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.048,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.4,
                      top: screenHeight * 0.798,
                      child: GestureDetector(
                        onTap: () {
                          if (selectedLanguage.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhoneNumber(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,  // You can customize the container's appearance
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.continue_button,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}