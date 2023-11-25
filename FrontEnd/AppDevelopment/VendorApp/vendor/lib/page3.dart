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
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          child: Builder(
            builder: (BuildContext builderContext) {
              return Container(
                width: screenWidth * 1,
                height: screenHeight * 1,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: const Color(0xFF6FB457)),
                child: Stack(
                  children: [
                    Positioned(
                      left: screenWidth * 0.0,
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.43,
                      child: Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.050,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.32,
                      top: screenHeight * 0.1,
                      child: Center(
                        child: Text(
                          'Wasail',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.120,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.320,
                      child: Text(
                        'Login',
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
                      left: screenWidth * 0.023,
                      top: screenHeight * 0.001,
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left_outlined, size: screenWidth * 0.106, color: Colors.white),
                          SizedBox(width: screenWidth * 0.012,),
                        ],
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.59,
                      child: Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.050,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.0625,
                      top: screenHeight * 0.72,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Reset',
                              style: TextStyle(
                                color: const Color(0xFF007AFF),
                                fontSize: screenWidth * 0.05,
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
                                fontSize: screenWidth * 0.05,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'Password',
                              style: TextStyle(
                                color: const Color(0xFF007AFF),
                                fontSize: screenWidth * 0.05,
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.64,
                      child: Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(color: const Color(0x72D9D9D9)),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.49,
                      child: Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(color: const Color(0x72D9D9D9)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.1,
                        top: screenHeight * 0.520,),
                      child: SizedBox(
                        width: screenWidth * 0.703,
                        height: screenHeight * 0.023,
                        child: TextField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.1,
                        top: screenHeight * 0.672,),
                      child: SizedBox(
                        width: screenWidth * 0.703,
                        height: screenHeight * 0.023,
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.8,
                      child: GestureDetector(
                        onTap: () {
                          // Close the keyboard when tapping the login button
                          FocusScope.of(context).unfocus();

                          // Retrieve values from text fields
                          String phoneNumber = phoneNumberController.text;
                          String password = passwordController.text;

                          // Navigate to the next page using the context obtained from Builder
                          Navigator.push(
                            builderContext,
                            MaterialPageRoute(
                              builder: (context) => Page4(
                                phoneNumber: phoneNumber,
                                password: password,
                              ),
                            ),
                          );
                        },
                        child: Positioned(
                          left: screenWidth * 0.07,
                          top: screenHeight * 0.765,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(screenHeight * 0.036),
                            ),
                            width: screenWidth * 0.870,
                            height: screenHeight * 0.072,
                            child: Center(
                              child: Text(
                                'Login',
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

class Page4 extends StatelessWidget {
  final String phoneNumber;
  final String password;

  const Page4({Key? key, required this.phoneNumber, required this.password})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Phone Number: $phoneNumber'),
            Text('Password: $password'),
          ],
        ),
      ),
    );
  }
}
