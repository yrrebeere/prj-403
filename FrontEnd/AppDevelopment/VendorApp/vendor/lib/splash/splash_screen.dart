import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Screens/PhoneNumber/phonenumber.dart';
import 'components/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'components/splash_content.dart';
import '../Screens/SelectLanguage/languageprovider.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  late List<Map<String, String>> splashData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    Locale? selectedLocale = languageProvider.selectedLocale;

    splashData = [
      {
        "text": AppLocalizations.of(context)!.welcome_msg,
        "image": "assets/images/splash_1.png"
      },
      {
        "text": "We help vendors to connect to grocery stores",
        "image": "assets/images/splash_2.png"
      },
      {
        "text": "We simplify the delivery process, making it efficient \n and effortless for you.",
        "image": "assets/images/splash_3.png"
      },
    ];

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: selectedLocale ?? Locale('en'), //
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[

                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"]!,
                      text: splashData[index]['text']!,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                                (index) => AnimatedContainer(
                              duration: kAnimationDuration,
                              margin: const EdgeInsets.only(right: 5),
                              height: 6,
                              width: currentPage == index ? 20 : 6,
                              decoration: BoxDecoration(
                                color: currentPage == index
                                    ? Color(0xFF6FB457)
                                    : const Color(0xFF6FB457),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(flex: 3),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PhoneNumber()),
                            );
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
                                AppLocalizations.of(context)!.continue_button,
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ),
                        ),
                        const Spacer(),
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
  }
}
