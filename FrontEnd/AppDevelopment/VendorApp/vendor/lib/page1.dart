import 'package:flutter/material.dart';
import 'page2.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  static const String routeName = "/page1";
  String selectedLanguage = '';

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
            builder: (BuildContext context) {
              return Container(
                width: screenWidth,
                height: screenHeight,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: screenHeight * 0.1,
                      child: Container(
                        width: screenWidth * 1.0,
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.35,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = 'English';
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'English'
                                ? Colors.blueAccent
                                : Colors.white,
                            boxShadow: [
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
                              'EN                         English',
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
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.45,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = 'Urdu';
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'Urdu'
                                ? Colors.blueAccent
                                : Colors.white,
                            boxShadow: [
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
                              'UR                             Urdu',
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
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.55,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedLanguage = 'Arabic';
                          });
                        },
                        child: Container(
                          width: screenWidth * 0.864,
                          height: screenHeight * 0.091,
                          decoration: BoxDecoration(
                            color: selectedLanguage == 'Arabic'
                                ? Colors.blueAccent
                                : Colors.white,
                            boxShadow: [
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
                      ),
                    ),
                    // Positioned(
                    //   left: screenWidth * 0.26,
                    //   top: screenHeight * 0.382,
                    //   child: SizedBox(
                    //     width: screenWidth * 0.8,
                    //     child: Text.rich(
                    //       TextSpan(
                    //         children: [
                    //           TextSpan(
                    //             text: 'EN                         ',
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: screenWidth * 0.048,
                    //               fontFamily: 'Inter',
                    //               fontWeight: FontWeight.w400,
                    //               height: 0,
                    //             ),
                    //           ),
                    //           TextSpan(
                    //             text: 'English',
                    //             style: TextStyle(
                    //               color: Colors.black.withOpacity(0.79),
                    //               fontSize: screenWidth * 0.048,
                    //               fontFamily: 'Inter',
                    //               fontWeight: FontWeight.w400,
                    //               height: 0,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   left: screenWidth * 0.26,
                    //   top: screenHeight * 0.482,
                    //   child: SizedBox(
                    //     width: screenWidth * 0.72,
                    //     child: Text.rich(
                    //       TextSpan(
                    //         children: [
                    //           TextSpan(
                    //             text: 'UR                             ',
                    //             style: TextStyle(
                    //               color: Colors.black,
                    //               fontSize: screenWidth * 0.048,
                    //               fontFamily: 'Inter',
                    //               fontWeight: FontWeight.w400,
                    //               height: 0,
                    //             ),
                    //           ),
                    //           TextSpan(
                    //             text: 'Urdu',
                    //             style: TextStyle(
                    //               color: Colors.black.withOpacity(0.79),
                    //               fontSize: screenWidth * 0.048,
                    //               fontFamily: 'Inter',
                    //               fontWeight: FontWeight.w400,
                    //               height: 0,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Positioned(
                    //   left: screenWidth * 0.26,
                    //   top: screenHeight * 0.582,
                    //   child: SizedBox(
                    //     width: screenWidth * 0.72,
                    //     child: Text(
                    //       'اردو                                اب',
                    //       style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: screenWidth * 0.048,
                    //         fontFamily: 'Inter',
                    //         fontWeight: FontWeight.w400,
                    //         height: 0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      left: screenWidth * 0.4,
                      top: screenHeight * 0.798,
                      child: GestureDetector(
                        onTap: () {
                          if (selectedLanguage.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Page2(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,  // You can customize the container's appearance
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            "Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}