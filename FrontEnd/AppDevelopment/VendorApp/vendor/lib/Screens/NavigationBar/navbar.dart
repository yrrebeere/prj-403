import 'package:flutter/material.dart';
import 'package:vendor/Screens/NavigationBar/Menu/menu.dart';
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';
import 'Home/home.dart';
import 'Inventory/inventory.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Screens/NavigationBar/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(NavBar());
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  final screens = [
    Home(),
    Order(),
    Inventory(),
    Menu(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
              padding: const EdgeInsets.only(left: 145),
              child: Text(AppLocalizations.of(context)!.app_name),
            ),
            elevation: 0,
          ),
          body: screens[index],
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade100,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              ),
            ),
            child: NavigationBar(
              selectedIndex: index,
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.home, color: Colors.grey), label: AppLocalizations.of(context)!.home),
                NavigationDestination(
                    icon: Icon(Icons.local_shipping, color: Colors.grey),
                    label: AppLocalizations.of(context)!.orders),
                NavigationDestination(
                    icon: Icon(Icons.list_alt_sharp, color: Colors.grey),
                    label: AppLocalizations.of(context)!.inventory),
                NavigationDestination(
                    icon: Icon(Icons.menu, color: Colors.grey), label: AppLocalizations.of(context)!.menu),
              ],
            ),
          ),
        ),
      );
    });
  }
}
