import 'package:flutter/material.dart';
import 'package:vendor/Screens/Login/login.dart';
import 'package:vendor/Screens/NavigationBar/Menu/viewprofile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vendor/main.dart';
import 'storelist.dart';
import '../../SelectLanguage/languageprovider.dart';
import '../../SelectLanguage/language.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VendorIdManager {
  static int? vendorId;

  static void logout() {
    vendorId = null;
  }
}

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String name = "John Doe"; // Initial values for demonstration
  String companyName = "ABC Company";

  @override
  void initState() {
    super.initState();
  }

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
          body: Container(
            child: SingleChildScrollView(
              child: Container(
                color: Color(0xfff2f2f6),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 1000,
                        width: 365,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6FB457),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                            Text(name, style: TextStyle(fontSize: 20)),
                            Text(companyName,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.grey)),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewProfile(),
                                  ),
                                );

                                if (result != null) {
                                  setState(() {
                                    name = result['name'];
                                    companyName = result['companyName'];
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF6FB457),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.view_profile,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.black, size: 20),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(AppLocalizations.of(context)!.other,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.format_list_bulleted_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.store_list,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Storelist(),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 20,
                                      )),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(AppLocalizations.of(context)!.general_settings,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.grey)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.help,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                      AppLocalizations.of(context)!.about,                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.privacy_policy,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.language,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.language,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.change_address,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.error,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.change_phone_number,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.black, size: 20),
                                ),
                              ],
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  VendorIdManager.logout();

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyVendorApp()),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.logout,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
