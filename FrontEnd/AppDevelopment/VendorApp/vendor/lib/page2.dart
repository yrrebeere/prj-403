import 'package:flutter/material.dart';
import 'page3.dart';

void main() {
  runApp(
    MaterialApp(
      home: Page2(),
    ),
  );
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _MyAppState();
}

class _MyAppState extends State<Page2> {
  final TextEditingController phoneNumberController = TextEditingController();

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
          child: Container(
            width: screenWidth * 1,
            height: screenHeight * 1,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: screenHeight * 0.2,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.718,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.023,
                  top: screenHeight * 0.001,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left_outlined, size: screenWidth * 0.106, color: Colors.black),
                        SizedBox(width: screenWidth * 0.012,),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.36,
                  top: screenHeight * 0.01,
                  child: Text(
                    'WASAIL',
                    style: TextStyle(
                      color: Color(0xFF6FB457),
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.07,
                  top: screenHeight * 0.2,
                  child: Text(
                    'Enter Phone Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.06,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.09,
                  top: screenHeight * 0.38,
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.2,
                  top: screenHeight * 0.4,
                  child: Text(
                    '+92',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.37,
                    top: screenHeight * 0.415,),
                  child: SizedBox(
                    width: screenWidth * 0.45,
                    height: screenHeight * 0.025,
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Eg.3144364288',
                        hintStyle: TextStyle(fontSize: screenWidth * 0.048,fontWeight: FontWeight.w400,),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.1,
                  top: screenHeight * 0.4,
                  child: Container(
                    width: screenWidth * 0.07,
                    height: screenHeight * 0.03,
                    child: Image.asset("assets/images/pakistan.png"),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.4,
                  top: screenHeight * 0.798,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page3(phoneNumber: phoneNumberController.text),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
