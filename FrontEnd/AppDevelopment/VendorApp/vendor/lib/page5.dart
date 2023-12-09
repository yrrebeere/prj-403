import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Page5(),
    ),
  );
}

class Page5 extends StatefulWidget {
  @override
  _Page5State createState() => _Page5State();
}

bool agreeToTerms = false;

class _Page5State extends State<Page5> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: SafeArea(
          child: Builder(
            builder: (BuildContext builderContext) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Positioned(
                  top: 30,
                  right: 150,
                  child: Container(
                      width: 430,
                      height: 1330,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 242, 246, 1),
                      ),
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 165,
                            left: 2,
                            right: 28,
                            child: Container(
                                width: 426,
                                height: 1065,
                                decoration: BoxDecoration(),
                                child: Stack(children: <Widget>[
                                  Positioned(
                                      top: 9,
                                      left: 22,
                                      child: Container(
                                          width: 423,
                                          height: 1022,
                                          child: Stack(children: <Widget>[
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: Text(
                                                  'Mobile Number',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 109,
                                                left: 0,
                                                child: Text(
                                                  'Password',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 36,
                                                left: 115,
                                                child: Container(
                                                    width: 265,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 153,
                                                left: 0,
                                                child: Container(
                                                    width: 380,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 161,
                                                left: 19,
                                                child: Text(
                                                  'Enter Password',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 226,
                                                left: 2,
                                                child: Text(
                                                  'Confirm Password',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 270,
                                                left: 2,
                                                child: Container(
                                                    width: 380,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 278,
                                                left: 21,
                                                child: Text(
                                                  'Re-Enter Password',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 461,
                                                left: 2,
                                                child: Text(
                                                  'Shop Name',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 505,
                                                left: 2,
                                                child: Container(
                                                    width: 380,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 513,
                                                left: 21,
                                                child: Text(
                                                  'Enter your shop name',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 579,
                                                left: 0,
                                                child: Text(
                                                  'Shop Address',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 623,
                                                left: 0,
                                                child: Container(
                                                    width: 380,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 631,
                                                left: 19,
                                                child: Text(
                                                  'Enter your shop address',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 732,
                                                left: 0,
                                                child: Text(
                                                  'Please enter your shop’s current location',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 16,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                              top: 900,
                                              left: 120,
                                              child: Container(
                                                  width: 200,
                                                  height: 200,
                                                  child: Text(
                                                    'Map here',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                    ),
                                                  )),
                                            ),
                                            Positioned(
                                              top: 980,
                                              left: -10,
                                              child: Row(
                                                children: [
                                                  Checkbox(
                                                    value: agreeToTerms,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        agreeToTerms =
                                                            value ?? false;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    'I agree to the Terms & Conditions and Privacy\nPolicy',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                                top: 698,
                                                left: 0,
                                                child: Text(
                                                  'Shop Location',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 343,
                                                left: 0,
                                                child: Text(
                                                  'Name',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 387,
                                                left: 0,
                                                child: Container(
                                                    width: 380,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 395,
                                                left: 19,
                                                child: Text(
                                                  'Enter your full name',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 20,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 36,
                                                left: 10,
                                                child: Container(
                                                    width: 99,
                                                    height: 42,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          217,
                                                          217,
                                                          217,
                                                          0.44999998807907104),
                                                    ))),
                                            Positioned(
                                                top: 44,
                                                left: 45,
                                                child: Text(
                                                  '+92',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 24,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 44,
                                                left: 174,
                                                child: Text(
                                                  '3144364288',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          0,
                                                          0,
                                                          0,
                                                          0.5799999833106995),
                                                      fontFamily: 'Inter',
                                                      fontSize: 24,
                                                      letterSpacing:
                                                      0 /*percentages not used in flutter. defaulting to zero*/,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      height: 1),
                                                )),
                                            Positioned(
                                                top: 49,
                                                left: 9,
                                                child: Container(
                                                    width: 30,
                                                    height: 15,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/Rectangle9.png'),
                                                          fit: BoxFit.fitWidth),
                                                    ))),
                                          ]))),
                                  Positioned(
                                    top: 1076,
                                    left: 28,
                                    child: Container(
                                      width: 360,
                                      height: 58,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                            Color.fromRGBO(0, 0, 0, 0.25),
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                          )
                                        ],
                                        color: agreeToTerms
                                            ? Color.fromRGBO(0, 122, 255,
                                            1) // Blue color if agreeToTerms is true
                                            : Colors
                                            .grey, // Grey color if agreeToTerms is false
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Inter',
                                            fontSize: 24,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]))),
                        Positioned(
                            top: -20,
                            left: -35,
                            child: Container(
                                width: 500,
                                height: 153.67596435546875,
                                child: Stack(children: <Widget>[
                                  Positioned(
                                      top: 0,
                                      left: 35,
                                      child: Container(
                                          width: 430,
                                          height: 139,
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ))),
                                  Positioned(
                                    left: 50,
                                    top: 70,
                                    child: GestureDetector(
                                      onTap: () {
                                        // Navigate back to the previous page
                                        // Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.chevron_left_outlined,
                                              size: 40, color: Colors.black),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 70,
                                    left: 170,
                                    child: Center(
                                      child: Text(
                                        'WASAIL',
                                        style: TextStyle(
                                          color: Color(0xFF6FB457),
                                          fontSize: 32,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 110,
                                      left: 150,
                                      child: Text(
                                        'Register Now',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontFamily: 'Inter',
                                            fontSize: 24,
                                            letterSpacing:
                                            0 /*percentages not used in flutter. defaulting to zero*/,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      )),
                                ]))),
                      ])),
                ),
              );
            },
          ),
        )),
      ),
    );
  }
}
