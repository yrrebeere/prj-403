import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: 430,
            height: 932,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Color(0xFF6FB457)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 222,
                  child: Container(
                    width: 430,
                    height: 710,
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
                  left: 27,
                  top: 361,
                  child: Text(
                    'Phone Number',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 142,
                  top: 113,
                  child: Text(
                    'Wasail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 254,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 847,
                  child: Container(
                    width: 360,
                    height: 58,
                    decoration: ShapeDecoration(
                      color: Color(0xFF007AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 188,
                  top: 861,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 11,
                  top: 69,
                  child: Container(
                    width: 122,
                    height: 21,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.20000000298023224),
                    ),
                  ),
                ),
                Positioned(
                  left: 44,
                  top: 69,
                  child: Text(
                    'Languages',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 473,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 585,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Reset',
                          style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Password',
                          style: TextStyle(
                            color: Color(0xFF007AFF),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 517,
                  child: Container(
                    width: 380,
                    height: 42,
                    decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                  ),
                ),
                Positioned(
                  left: 27,
                  top: 405,
                  child: Container(
                    width: 380,
                    height: 42,
                    decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                  ),
                ),
                Positioned(
                  left: 46,
                  top: 414,
                  child: Text(
                    '+923144364288',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5799999833106995),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 46,
                  top: 525,
                  child: SizedBox(
                    width: 295,
                    height: 20,
                    child: Text(
                      'Enter Password',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5799999833106995),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
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