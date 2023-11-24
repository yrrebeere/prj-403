import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6FB457),
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            width: screenWidth,
            height: screenHeight,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF6FB457)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: screenHeight * 0.28,
                  child: Container(
                    width: screenWidth * 1.0,
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
                  left: screenWidth * 0.35,
                  top: screenHeight * 0.053,
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
                  left: screenWidth * 0.0875,
                  top: screenHeight * 0.320,
                  child: Text(
                    'Select Language',
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
                  left: screenWidth * 0.0875,
                  top: screenHeight * 0.395,
                  child: Container(
                    width: screenWidth * 0.83,
                    height: screenHeight * 0.091,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.0875,
                  top: screenHeight * 0.495,
                  child: Container(
                    width: screenWidth * 0.83,
                    height: screenHeight * 0.091,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.0875,
                  top: screenHeight * 0.595,
                  child: Container(
                    width: screenWidth * 0.83,
                    height: screenHeight * 0.091,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.175,
                  top: screenHeight * 0.425,
                  child: SizedBox(
                    width: screenWidth * 0.8,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'EN                         ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.048,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'English',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.79),
                              fontSize: screenWidth * 0.048,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.175,
                  top: screenHeight * 0.525,
                  child: SizedBox(
                    width: screenWidth * 0.72,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'UR                             ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.048,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'Urdu',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.79),
                              fontSize: screenWidth * 0.048,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.175,
                  top: screenHeight * 0.625,
                  child: SizedBox(
                    width: screenWidth * 0.72,
                    child: Text(
                      'اردو                                اب',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.048,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.07,
                  top: screenHeight * 0.765,
                  child: Container(
                    width: screenWidth * 0.870,
                    height: screenHeight * 0.072,
                    decoration: ShapeDecoration(
                      color: Color(0xFF007AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenHeight * 0.036),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.048,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
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
