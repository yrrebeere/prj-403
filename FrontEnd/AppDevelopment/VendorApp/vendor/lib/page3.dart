import 'package:flutter/material.dart';
import 'page4.dart';

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
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (BuildContext builderContext) {
              return Container(
                width: 430,
                height: 932,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: const Color(0xFF6FB457)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 222,
                      child: Container(
                        width: 392,
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
                      left: 130,
                      top: 113,
                      child: Center(
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
                        width: 330,
                        height: 58,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF007AFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          shadows: [
                            BoxShadow(
                              color: const Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 188,
                      top: 861,
                      child: ElevatedButton(
                        onPressed: () {
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
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
                    ),
                    Positioned(
                      left: 11,
                      top: 69,
                      child: Container(
                        width: 122,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 72,
                      child: Row(
                        children: [
                          Icon(Icons.language, size: 16, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Languages',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
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
                                color: const Color(0xFF007AFF),
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
                                color: const Color(0xFF007AFF),
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
                        width: 340,
                        height: 42,
                        decoration: BoxDecoration(color: const Color(0x72D9D9D9)),
                      ),
                    ),
                    Positioned(
                      left: 27,
                      top: 405,
                      child: Container(
                        width: 340,
                        height: 42,
                        decoration: BoxDecoration(color: const Color(0x72D9D9D9)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45, top: 425),
                      child: SizedBox(
                        width: 300,
                        height: 20,
                        child: TextField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 45, top: 538),
                      child: SizedBox(
                        width: 300,
                        height: 20,
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
                      left: 30,
                      top: 680,
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
                          left: 30,
                          top: 680,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            height: 50,
                            width: 340,
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
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
