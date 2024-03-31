import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:store/Screens/PhoneNumber/phonenumber.dart';
import 'package:store/Screens/Registration/registrationprovider.dart';
import '../PhoneNumber/phonenumberprovider.dart';
import 'package:provider/provider.dart';
import 'languageprovider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider<UserIdProvider>(
            create: (_) => UserIdProvider()
        ),
        ChangeNotifierProvider<PhoneNumberProvider>(
          create: (context) => PhoneNumberProvider(),
        ),// ChangeNotifierProvider
        // ChangeNotifierProvider<LoginChangeNotifier>(
        //   create: (context) => LoginChangeNotifier(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Language(),
      ),
    );
  }
}

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    LanguageProvider languageProvider =
    Provider.of<LanguageProvider>(context, listen: false);
    Locale? selectedLocale = languageProvider.selectedLocale;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.ltr, // or TextDirection.rtl
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: selectedLocale ?? Locale('en'), // Fallback to 'en' if selectedLocale is null

        home: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   elevation: 0,
          // ),
          body: SafeArea(
            child: Builder(
              builder: (BuildContext context) {
                LanguageProvider languageProvider =
                Provider.of<LanguageProvider>(context, listen: false);
                Locale? selectedLocale = languageProvider.selectedLocale;

                return Container(
                  width: screenWidth,
                  height: screenHeight,
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
                      // Positioned(
                      //   left: 0,
                      //   top: screenHeight * 0.1,
                      //   child: Container(
                      //     width: screenWidth * 1.0,
                      //     height: screenHeight * 0.718,
                      //     decoration: ShapeDecoration(
                      //       color: Colors.white,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(10),
                      //           topRight: Radius.circular(10),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        right: screenWidth * -0.04,
                        top: screenHeight * 0.18,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 9.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF6FB457), Colors.orangeAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.app_type,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.40,
                        top: screenHeight * 0.25,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.welcome_msg,
                            style: TextStyle(
                              color:Colors.orangeAccent,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.45,
                        top: screenHeight * 0.29,
                        child: Icon(
                          Icons.store,
                          size: 60,
                          color: Colors.orangeAccent,
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
                        left: screenWidth * 0.35,
                        top: screenHeight * 0.42,
                        child: Text(
                          AppLocalizations.of(context)!.select_lang,
                          style: TextStyle(
                            color:Color(0xFF6FB457),
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.07,
                        top: screenHeight * 0.48,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLanguage = 'English';
                            });
                            Provider.of<LanguageProvider>(context, listen: false)
                                .setSelectedLocale(Locale('en'));
                          },
                          child: Container(
                            width: screenWidth * 0.864,
                            height: screenHeight * 0.091,
                            decoration: BoxDecoration(
                              gradient: selectedLanguage == 'English'
                                  ? LinearGradient(
                                colors: [
                                  Color(0xFF6FB457),
                                  Colors.orangeAccent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: selectedLanguage == 'English'
                                  ? null
                                  : Colors.white ,
                              borderRadius: BorderRadius.circular(8.0),
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
                                  color: selectedLanguage == 'English' ? Colors.white : Colors.black, // Change color conditionally
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
                        top: screenHeight * 0.58,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedLanguage = 'Urdu';
                            });
                            Provider.of<LanguageProvider>(context, listen: false)
                                .setSelectedLocale(Locale('ur'));
                          },
                          child: Container(
                            width: screenWidth * 0.864,
                            height: screenHeight * 0.091,
                            decoration: BoxDecoration(
                              gradient: selectedLanguage == 'Urdu'
                                  ? LinearGradient(
                                colors: [
                                  Color(0xFF6FB457),
                                  Colors.orangeAccent,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: selectedLanguage == 'Urdu'
                                  ? null
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
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
                                  color: selectedLanguage == 'Urdu' ? Colors.white : Colors.black, // Change color conditionally
                                  fontSize: screenWidth * 0.048,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.35,
                        top: screenHeight * 0.76,
                        child: GestureDetector(
                          onTap: () {
                            if (selectedLocale != null &&
                                selectedLocale.languageCode.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneNumber(),
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: screenWidth * 0.3,
                            // Adjust the width as needed
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!.continue_button,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.45,
                        bottom: screenHeight * 0.03,
                        child: IconButton(
                          onPressed: () {
                            // Add functionality for email icon
                          },
                          icon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.33,
                        bottom: screenHeight * 0.03,
                        child: IconButton(
                          onPressed: () {
                            // Add functionality for Instagram icon
                          },
                          icon: Icon(
                            Icons.call,
                            color: Colors.redAccent,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        right: screenWidth * 0.54,
                        bottom: screenHeight * 0.03,
                        child: IconButton(
                          onPressed: () {
                            // Add functionality for Instagram icon
                          },
                          icon: Icon(
                            Icons.comment_bank_outlined,
                            color: Colors.blue,
                            size: 25,
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
      ),
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

