import 'package:flutter/material.dart';
import 'package:vendor/menu.dart';
import 'package:vendor/orders.dart';
import 'home.dart';
import 'orders.dart';
import 'menu.dart';
import 'inventory.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';


void main() {
  runApp(
    // Wrap your app with MultiProvider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()), // or your provider setup
        // Add other providers if needed
      ],
      child: NavBar(),
    ),
  );
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

    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: ThemeData.light(), // Your default theme
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF6FB457),
              title: Padding(
                padding: const EdgeInsets.only(left: 145),
                child: Text('WASAIL'),
              ),
              elevation: 0,
            ),
            body: screens[index],
            bottomNavigationBar: NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorColor: Colors.blue.shade100,
                labelTextStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey),
                ),
              ),
              child: NavigationBar(
                selectedIndex: index,
                onDestinationSelected: (index) => setState(() => this.index = index),
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home, color: Colors.grey), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.local_shipping, color: Colors.grey), label: 'Orders'),
                  NavigationDestination(icon: Icon(Icons.list_alt_sharp, color: Colors.grey), label: 'Inventory'),
                  NavigationDestination(icon: Icon(Icons.menu, color: Colors.grey), label: 'Menu'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

