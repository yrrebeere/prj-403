import 'package:flutter/material.dart';
class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
    elevation: 0,
    ),
    body: SafeArea(
    child: Builder(
    builder: (BuildContext builderContext) {
    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        height: screenHeight,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color:Colors.black12),
        child: Column(
          children: [
            Container(
              width: screenWidth * 2,
              height: screenHeight * 0.1,
              color: Colors.white,
              child: Center(child: Text('Register Now', style: TextStyle(fontSize: screenWidth * 0.04),),),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text('Mobile Number',style: TextStyle(fontSize: screenWidth * 0.04),),
                ),
              ],
            ),
            Row(
              children: [
                Positioned(
                  left: screenWidth * 0.2,
                  top: screenHeight * 0.4,
                  child: Text(
                    '+92',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.04,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.1,
                  top: screenHeight * 0.4,
                  child: Container(
                    width: screenWidth * 0.07,
                    height: screenHeight * 0.03,
                    child: Image.asset("assets/images/pakistan.png"), // Adjust the path accordingly
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left:20, top: 30),
                    child: SizedBox(
                      width: screenWidth * 0.45,
                      height: screenHeight * 0.025,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Eg.3144364288',
                          hintStyle: TextStyle(fontSize: screenWidth * 0.035),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        )
      ),
    );
    },
    ),
    ),
        ),
    );
  }
}


