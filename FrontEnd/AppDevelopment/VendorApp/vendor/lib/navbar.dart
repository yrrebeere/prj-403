import 'package:flutter/material.dart';
import 'package:vendor/menu.dart';
import 'package:vendor/orders.dart';
import 'home.dart';
import 'orders.dart';
import 'menu.dart';
import 'inventory.dart';

void main() {
  runApp(
      MaterialApp(
        home: NavBar(
        ),
      )
  );
}
class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index=0;
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

    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xFF6FB457),
      title:Padding(
        padding: const EdgeInsets.only(left: 90),
        child: Text('WASAIL'),
      ),
      elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), // Replace with your desired icon
          onPressed: () {
            // Handle the icon tap (e.g., open a drawer)
          },
        ),
    ),
    body:  screens[index],
    bottomNavigationBar: NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: Colors.blue.shade100,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey),
        ),
      ),
      child: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index =index),
        destinations: [
          NavigationDestination(icon: Icon(Icons.home,color: Colors.grey), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.local_shipping,color: Colors.grey), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.list_alt_sharp,color: Colors.grey), label: 'Inventory'),
          NavigationDestination(icon: Icon(Icons.menu,color: Colors.grey), label: 'Menu'),
        ],
      ),
    ),

      ),
    );
  }
}
