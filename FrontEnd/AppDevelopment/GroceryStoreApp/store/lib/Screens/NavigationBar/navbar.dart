import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:store/Screens/NavigationBar/Menu/menu.dart';
import 'package:store/Screens/NavigationBar/Orders/orders.dart';
import 'Home/home.dart';
import 'Inventory/inventory.dart';
import 'package:provider/provider.dart';
import 'package:store/Screens/NavigationBar/navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Registration/registrationprovider.dart';
import '../SelectLanguage/languageprovider.dart';
import 'package:flutter/services.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

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
              backgroundColor: Colors.transparent, // Make app bar transparent
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6FB457), Color(0xFF6FB457)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 145),
                child: Text(AppLocalizations.of(context)!.app_name),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    // Handle cart icon tap
                  },
                ),
              ],
            ),
            body: screens[index],
            bottomNavigationBar: CurvedNavigationBar(
              index: index,
              backgroundColor: Colors.white,
              color: Colors.orangeAccent,
              buttonBackgroundColor: Colors.deepOrangeAccent,
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
