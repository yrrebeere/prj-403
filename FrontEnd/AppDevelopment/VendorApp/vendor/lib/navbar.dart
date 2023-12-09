import 'package:flutter/material.dart';
import 'home.dart';

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
    Center(child: Text('Orders', style: TextStyle(fontSize:72),),),
    Center(child: Text('Inventory', style: TextStyle(fontSize:72),),),
    Center(child: Text('Menu', style: TextStyle(fontSize:72),),)
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
      backgroundColor: Color(0xFF6FB457),
      title: Center(child: Text('WASAIL')),

      elevation: 0,
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
