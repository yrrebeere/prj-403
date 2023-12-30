import 'package:flutter/material.dart';
import 'package:vendor/Screens/NavigationBar/Orders/orders.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xfff2f2f6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          GestureDetector(
            // onTap: () {
            //   // Ensure that you're using the context from the Navigator widget
            //   Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => Order(),
            //     ),
            //   );
            // },
            child: Container(
              height: 160,
              width: 380,
              decoration: BoxDecoration(
                  color: Color(0xFF141022),
                borderRadius: BorderRadius.circular(20),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('You have',style: TextStyle(color: Colors.white, fontSize: 18),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('15',style: TextStyle(color: Colors.white, fontSize: 30),),
                          Icon(Icons.arrow_forward_ios, color: Colors.white),
                        ],
                      ),
                      Row(
                      children: [
                        Text('Total Orders today',style: TextStyle(color: Colors.white, fontSize: 18),),
                      ],
                    ),
                    ],
                  ),
                ),
            ),
          )
        ],
      ),
    );
  }
}
