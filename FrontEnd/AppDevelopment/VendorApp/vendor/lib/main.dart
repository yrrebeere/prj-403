import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'Classes/languageprovider.dart';
import 'Screens/SelectLanguage/language.dart';
import 'Classes/phonenumberprovider.dart';
import 'package:vendor/Classes/registrationprovider.dart';

void main() => runApp(MyVendorApp());

class MyVendorApp extends StatelessWidget {
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
        home: Builder(
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Language(),
            );
          },
        ),
      ),
    );
  }
}
