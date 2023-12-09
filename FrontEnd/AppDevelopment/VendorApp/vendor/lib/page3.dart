import 'package:flutter/material.dart';
import 'page4.dart';

class Page3 extends StatefulWidget {
  final String phoneNumber;

  const Page3({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Page3> createState() => _MyAppState();
}

class _MyAppState extends State<Page3> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              return Container(
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.33,
                      child: Text(
                        'Phone Number',
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
                      left: screenWidth * 0.36,
                      top: screenHeight * 0.01,
                      child: Center(
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
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.2,
                      child: Text(
                        'Login',
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
                      left: screenWidth * 0.023,
                      top: screenHeight * 0.001,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate back to the previous page
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.46,
                      child: Text(
                        'Password',
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
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.6,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Reset',
                              style: TextStyle(
                                color: const Color(0xFF007AFF),
                                fontSize: screenWidth * 0.04,
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
                                fontSize: screenWidth * 0.04,
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
                                fontSize: screenWidth * 0.04,
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
                      top: screenHeight * 0.5,
                      child: Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color to white
                          border: Border.all(
                            color: Colors.black, // Set the border color to black
                            width: 1.0, // Set the border width (adjust as needed)
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.37,
                      child: Container(
                        width: screenWidth * 0.85,
                        height: screenHeight * 0.065,
                        decoration: BoxDecoration(
                          color: Colors.white, // Set the background color to white
                          border: Border.all(
                            color: Colors.black, // Set the border color to black
                            width: 1.0, // Set the border width (adjust as needed)
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.10,
                      top: screenHeight * 0.387,
                      child: Text(
                        '0${widget.phoneNumber}',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: screenWidth * 0.1,
                        top: screenHeight * 0.53,),
                      child: SizedBox(
                        width: screenWidth * 0.703,
                        height: screenHeight * 0.023,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.4,
                      top: screenHeight * 0.798,
                      child: GestureDetector(
                        onTap: () {
                          // Close the keyboard when tapping the login button
                          FocusScope.of(context).unfocus();

                          // Retrieve values from text fields
                          String password = passwordController.text;

                          // Navigate to the next page using the context obtained from Builder
                          Navigator.push(
                            builderContext,
                            MaterialPageRoute(
                              builder: (context) => Page4(
                                password: password,
                                phoneNumber: widget.phoneNumber,
                              ),
                            ),
                          );
                        },
                        child: Positioned(
                          left: screenWidth * 0.4,
                          top: screenHeight * 0.798,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(screenHeight * 0.03),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,  // You can customize the container's appearance
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
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