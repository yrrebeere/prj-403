import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'Screens/SelectLanguage/languageprovider.dart';  // Adjust the import based on your project structure
import 'Screens/SelectLanguage/language.dart';  // Adjust the import based on your project structure

void main() => runApp(MyVendorApp());

class MyVendorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Language(),
      ),
    );
  }
}
