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
        backgroundColor: Color(0xFFF2F2F6),
    elevation: 0,
    ),
    body: SafeArea(
    child: Builder(
    builder: (BuildContext builderContext) {
    return Container(
      width: 430,
      height: 1330,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Color(0xFFF2F2F6)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 500,
            height: 153.68,
            child: Stack(
              children: [
                Positioned(
                  left: 35,
                  top: 0,
                  child: Container(
                    width: 430,
                    height: 139,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 53,
                  top: 77,
                  child: Container(
                    width: 25,
                    height: 25,
                    padding: const EdgeInsets.symmetric(horizontal: 1.56, vertical: 1.84),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 174,
                  top: 79,
                  child: Text(
                    'Register Now',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 118,
                  child: Container(
                    width: 500,
                    height: 35.68,
                    padding: const EdgeInsets.symmetric(horizontal: 31.25),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 11.32),
          Container(
            width: 426,
            height: 1165,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 423,
                  height: 1022,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Text(
                          'Mobile Number',
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
                        left: 0,
                        top: 109,
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
                        left: 115,
                        top: 36,
                        child: Container(
                          width: 265,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 153,
                        child: Container(
                          width: 380,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 161,
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
                      Positioned(
                        left: 2,
                        top: 226,
                        child: Text(
                          'Confirm Password',
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
                        left: 2,
                        top: 270,
                        child: Container(
                          width: 380,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 21,
                        top: 278,
                        child: SizedBox(
                          width: 295,
                          height: 20,
                          child: Text(
                            'Re-Enter Password',
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
                      Positioned(
                        left: 2,
                        top: 461,
                        child: Text(
                          'Shop Name',
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
                        left: 2,
                        top: 505,
                        child: Container(
                          width: 380,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 21,
                        top: 513,
                        child: SizedBox(
                          width: 295,
                          height: 20,
                          child: Text(
                            'Enter your shop name',
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
                      Positioned(
                        left: 0,
                        top: 579,
                        child: Text(
                          'Shop Address',
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
                        left: 0,
                        top: 623,
                        child: Container(
                          width: 380,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 631,
                        child: SizedBox(
                          width: 295,
                          height: 20,
                          child: Text(
                            'Enter your shop address',
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
                      Positioned(
                        left: 0,
                        top: 732,
                        child: SizedBox(
                          width: 388,
                          height: 20,
                          child: Text(
                            'Please enter your shop’s current location',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5799999833106995),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 35,
                        top: 1002,
                        child: SizedBox(
                          width: 388,
                          height: 20,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5799999833106995),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(
                                    color: Color(0xFFDF1111),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' and \n',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5799999833106995),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Color(0xFFDF1111),
                                    fontSize: 16,
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
                        left: 0,
                        top: 698,
                        child: Text(
                          'Shop Location',
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
                        left: 0,
                        top: 343,
                        child: Text(
                          'Name',
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
                        left: 0,
                        top: 387,
                        child: Container(
                          width: 380,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 19,
                        top: 395,
                        child: SizedBox(
                          width: 295,
                          height: 20,
                          child: Text(
                            'Enter your full name',
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
                      Positioned(
                        left: 0,
                        top: 36,
                        child: Container(
                          width: 99,
                          height: 42,
                          decoration: BoxDecoration(color: Color(0x72D9D9D9)),
                        ),
                      ),
                      Positioned(
                        left: 45,
                        top: 44,
                        child: SizedBox(
                          width: 47,
                          height: 20,
                          child: Text(
                            '+92',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5799999833106995),
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 174,
                        top: 44,
                        child: SizedBox(
                          width: 147,
                          height: 20,
                          child: Text(
                            '3144364288',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5799999833106995),
                              fontSize: 24,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 9,
                        top: 49,
                        child: Container(
                          width: 30,
                          height: 15,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/30x15"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 380,
                  height: 216,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/380x216"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: 21,
                  height: 15,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(
                  width: 360,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Color(0xFF007AFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
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


