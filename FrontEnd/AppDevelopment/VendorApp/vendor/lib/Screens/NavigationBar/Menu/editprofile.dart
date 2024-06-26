import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../Classes/languageprovider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
      return MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: languageProvider.selectedLocale,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: child!,
          );
        },
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF6FB457),
            title: Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Text(AppLocalizations.of(context)!.app_name,
              ),
            ),
            elevation: 0,
            leading: IconButton(
              icon: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.enter_name),
                ),

                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    // Add logic to save changes and update the profile
                    String newName = nameController.text;

                    print('New Name: $newName');

                    Map<String, String> updatedData = {
                      'name': newName,
                    };

                    Navigator.pop(context, updatedData);
                  },
                  child: Text(AppLocalizations.of(context)!.save_changes),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
