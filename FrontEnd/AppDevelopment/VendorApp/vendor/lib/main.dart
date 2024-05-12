import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'Screens/SelectLanguage/languageprovider.dart';
import 'Screens/SelectLanguage/language.dart';
import 'Screens/PhoneNumber/phonenumberprovider.dart';
import 'package:vendor/Screens/Registration/registrationprovider.dart';

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
