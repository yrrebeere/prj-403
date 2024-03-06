import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:vendor/Screens/PhoneNumber/phonenumber.dart';
// import 'package:vendor/Screens/Registration/registrationprovider.dart';
// import '../PhoneNumber/phonenumberprovider.dart';
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
        // ChangeNotifierProvider<UserIdProvider>(
        //     create: (_) => UserIdProvider()
        // ),
        // ChangeNotifierProvider<PhoneNumberProvider>(
        //   create: (context) => PhoneNumberProvider(),
        // ),// ChangeNotifierProvider<LoginChangeNotifier>(
        //   create: (context) => LoginChangeNotifier(),
        // ),
      ],
      child: MaterialApp(
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

    return MaterialApp(

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: selectedLocale ?? Locale('en'), // Fallback to 'en' if selectedLocale is null

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
                      left: screenWidth * 0.28,
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
                          Provider.of<LanguageProvider>(context, listen: false)
                              .setSelectedLocale(Locale('en'));
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'English'
                                ? Color(0xFF6FB457)
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
                          Provider.of<LanguageProvider>(context, listen: false)
                              .setSelectedLocale(Locale('ur'));
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'Urdu'
                                ? Color(0xFF6FB457)
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
                      left: screenWidth * 0.35,
                      top: screenHeight * 0.76,
                      child: GestureDetector(
                        // onTap: () {
                        //   if (selectedLocale != null &&
                        //       selectedLocale.languageCode.isNotEmpty) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => PhoneNumber(),
                        //       ),
                        //     );
                        //   }
                        // },
                        child: Container(
                          width: screenWidth * 0.3,
                          // Adjust the width as needed
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF6FB457),
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
