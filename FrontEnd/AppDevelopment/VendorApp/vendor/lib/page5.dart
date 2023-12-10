import 'package:flutter/material.dart';
import 'home.dart';

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

class _Page5State extends State<Page5> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopAddressController = TextEditingController();
  final TextEditingController shopLocationController = TextEditingController();

  bool agreeToTerms = false;
  String selectedCountryCode = '+92';

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
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth * 1,
              height: screenHeight * 1,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  Positioned(
                    right: screenWidth * 0.8,
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
                    left: screenWidth * 0.31,
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
                    left: screenWidth * 0.15,
                    top: screenHeight * 0.08,
                    child: Text(
                      'Enter Registration Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.05,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth * 0.0,
                    top: screenHeight * 0.14,
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text(
                              'Mobile Number:',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: screenWidth * 0.2,
                                child: DropdownButton<String>(
                                  value: selectedCountryCode,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCountryCode = newValue!;
                                    });
                                  },
                                  items: <String>['+92', '+1', '+44', '+81']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 8),
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                width: screenWidth * 0.6,
                                child: TextField(
                                  controller: phoneNumberController,
                                  decoration: InputDecoration(
                                    hintText: 'Eg. 3355600598',
                                    hintStyle: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.25,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.28,
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.38,
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.41,
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Confirm your password',
                          hintStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.51,
                    child: Text(
                      'Full Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.55,
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: nameController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          hintStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.66,
                    child: Text(
                      'Shop Address',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.7,
                    child: Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: shopAddressController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your shop address',
                          hintStyle: TextStyle(
                            fontSize: screenWidth * 0.035,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: screenHeight * 0.8,
                    child: Row(
                      children: [
                        Checkbox(
                          value: agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreeToTerms = value!;
                            });
                          },
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'I agree to the ',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(
                                  color:Color(0xFF6FB457),
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color:Color(0xFF6FB457),
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.9,
                    left: screenWidth * 0.4,
                    bottom: screenHeight * 0.05,
                    child: GestureDetector(
                      onTap: () {
                        if (agreeToTerms) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                // phoneNumber: phoneNumberController.text,
                                // Pass other registration data here
                                //where is this data going
                              ),
                            ),
                          );
                        } else {
                          print(
                              'Please agree to Terms and Conditions and Privacy Policy.');
                        }
                      },
                      child: IgnorePointer(
                        ignoring: !agreeToTerms,
                        child: Opacity(
                          opacity: agreeToTerms ? 1.0 : 0.5,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              color:Color(0xFF6FB457),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
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
      ),
    );
  }
}
