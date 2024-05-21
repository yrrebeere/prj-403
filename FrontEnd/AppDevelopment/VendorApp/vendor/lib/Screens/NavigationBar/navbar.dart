import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:vendor/Screens/NavigationBar/Menu/menu.dart';
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';
import 'Home/home.dart';
import 'Inventory/inventory.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Registration/registrationprovider.dart';
import '../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';

class NavBar extends StatefulWidget {
  final int initialIndex;

  const NavBar({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int index;

  final screens = [
    Home(),
    Order(),
    Inventory(),
    Menu(),
  ];

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    var userIdProvider = Provider.of<UserIdProvider>(context, listen: false);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        print("Nav Bar Selected Locale: ${languageProvider.selectedLocale}");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
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
              backgroundColor: Color(0xFFFF9100), // Make app bar transparent
              flexibleSpace: Container(
                decoration: BoxDecoration(),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 145),
                child: Text(AppLocalizations.of(context)!.app_name),
              ),
              elevation: 0,
            ),
            body: screens[index],
            bottomNavigationBar: CurvedNavigationBar(
              index: index,
              backgroundColor: Colors.white,
              color:  Color(0xFFFF9100),
              buttonBackgroundColor:  Color(0xFFFF9100),
              animationDuration: Duration(milliseconds: 300),
              items: <Widget>[
                Icon(Icons.home, size: 30, color: Colors.white,),
                Icon(Icons.local_shipping, size: 30, color: Colors.white,),
                Icon(Icons.contact_page, size: 30, color: Colors.white,),
                Icon(Icons.menu, size: 30, color: Colors.white,),
              ],
              onTap: (newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
