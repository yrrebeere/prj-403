import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'page5.dart';
import 'page5.dart';


class Page4 extends StatefulWidget {
  final String password;
  final String phoneNumber;

  const Page4({Key? key, required this.password, required this.phoneNumber}) : super(key: key);

  @override
  State<Page4> createState() => _MyAppState();
}

class _MyAppState extends State<Page4> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  late Timer _timer;
  int _timerSeconds = 15;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_timer == null || !_timer.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_timerSeconds > 0) {
            _timerSeconds--;
          } else {
            _timer.cancel();
          }
        });
      });
    }
  }

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
                width: screenWidth,
                height: screenHeight,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  children: [
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
                        'Enter your code',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.06,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.023,
                      top: screenHeight * 0.001,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.chevron_left_outlined, size: screenWidth * 0.106, color: Colors.black),
                            SizedBox(width: screenWidth * 0.012),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.07,
                      top: screenHeight * 0.26,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Code sent on',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.85),
                                fontSize: screenHeight * 0.02,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' 0${widget.phoneNumber} ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenHeight * 0.02,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.09,
                      top: screenHeight * 0.3,
                      child: Row(
                        children: List.generate(4, (index) {
                          return Padding(
                            padding: EdgeInsets.only(right: screenWidth * 0.05),
                            child: SizedBox(
                              height: screenHeight * 0.1,
                              width: screenWidth * 0.17,
                              child: TextFormField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (index < _focusNodes.length - 1) {
                                      _focusNodes[index + 1].requestFocus();
                                    } else {
                                      _focusNodes[index].unfocus();
                                    }
                                    _startTimer();
                                  }
                                },
                                style: Theme.of(context).textTheme.headline6,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.09,
                      top: screenHeight * 0.4,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Re-send',
                              style: TextStyle(
                                color: _timerSeconds == 0 ? Color(0xFF007AFF) : Color(0xFF99999D),
                                fontSize: screenHeight * 0.02,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' code in ',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.85),
                                fontSize: screenHeight * 0.02,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: screenWidth * 0.42,
                      top: screenHeight * 0.4,
                      child: TweenAnimationBuilder(
                        tween: Tween(begin: 30.0, end: 0.0),
                        duration: const Duration(seconds: 30),
                        builder: (_, dynamic value, child) => Text(
                          "00:${value.toInt()}",
                          style: const TextStyle(color: Colors.cyan,fontSize:18 ),
                        ),
                      ),

                    ),
                    Positioned(
                      left: screenWidth * 0.4,
                      top: screenHeight * 0.798,
                      child: GestureDetector(
                        onTap: () {
                          if (_controllers.every((controller) => controller.text.isNotEmpty)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Page5(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please fill in all fields.'),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: screenWidth * 0.2,
                          height: screenHeight * 0.055,
                          decoration: ShapeDecoration(
                            color: Color(0xFF007AFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(screenHeight * 0.0428),
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
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
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
