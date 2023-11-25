import 'package:flutter/material.dart';
import 'page3.dart';

void main() {
  runApp(const Page2());
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
          backgroundColor: const Color(0xFF6FB457),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            width: screenWidth * 1,
            height: screenHeight * 1,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: const Color(0xFF6FB457)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: screenHeight * 0.28,
                  child: Container(
                    width: screenWidth,
                    height: screenHeight * 0.718,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
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
                      // Navigate back to the previous page
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left_outlined, size: screenWidth * 0.106, color: Colors.white),
                        SizedBox(width: screenWidth * 0.012,),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.32,
                  top: screenHeight * 0.1,
                  child: Text(
                    'Wasail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.07,
                  top: screenHeight * 0.32,
                  child: Text(
                    'Enter Phone Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.075,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.39,
                  top: screenHeight * 0.50625,
                  child: Container(
                    width: screenWidth * 0.55,
                    height: screenHeight * 0.07625,
                    decoration: BoxDecoration(color: const Color(0x72D9D9D9)),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.07,
                  top: screenHeight * 0.50625,
                  child: Container(
                    width: screenWidth * 0.3,
                    height: screenHeight * 0.07625,
                    decoration: BoxDecoration(color: const Color(0x72D9D9D9)),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.2,
                  top: screenHeight * 0.52625,
                  child: Text(
                    '+92',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: screenWidth * 0.058,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.43,
                    top: screenHeight * 0.538,),
                  child: SizedBox(
                    width: screenWidth * 0.47,
                    height: screenHeight * 0.023,
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        hintText: 'Eg.3144364288',
                        hintStyle: TextStyle(fontSize: screenWidth * 0.05),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.1,
                  top: screenHeight * 0.52625,
                  child: Container(
                    width: screenWidth * 0.07,
                    height: screenHeight * 0.03,
                    child: Image.asset("assets/images/pakistan.png"), // Adjust the path accordingly
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.07,
                  top: screenHeight * 0.8,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to Page3 and pass the entered phone number
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Page3(phoneNumber: phoneNumberController.text),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF007AFF),
                        borderRadius: BorderRadius.circular(screenHeight * 0.036),
                      ),
                      width: screenWidth * 0.87,
                      height: screenHeight * 0.072,
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.058,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
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
