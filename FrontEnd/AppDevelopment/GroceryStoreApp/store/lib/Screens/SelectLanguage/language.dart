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
        ),
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
      textDirection: TextDirection.ltr,
      child: Scaffold(
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
                      right: screenWidth * 0.25,
                      top: screenHeight * 0.18,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 9.0),
                        color: Colors.green,
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
                      top: screenHeight * 0.3,
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.welcome_msg,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w400,
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
                          color: Colors.green,
                          fontSize: 32,
                          fontFamily: 'Inter',
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.34,
                      top: screenHeight * 0.4,
                      child: Text(
                        AppLocalizations.of(context)!.select_lang,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.5,
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
                            color: selectedLanguage == 'English' ? Colors.green : Colors.white,
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
                                color: selectedLanguage == 'English' ? Colors.white : Colors.black,
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
                      top: screenHeight * 0.6,
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
                            color: selectedLanguage == 'Urdu' ? Colors.green : Colors.white,
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
                                color: selectedLanguage == 'Urdu' ? Colors.white : Colors.black,
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
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.green,
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
