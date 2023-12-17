import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'constants.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('ur', 'en'),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Text(
                AppLocalizations.of(context)!.app_name,
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF6FB457),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                text!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16), // Adding some space between text and image
              Image.asset(
                image!,
                height: 265,
                width: 235,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
