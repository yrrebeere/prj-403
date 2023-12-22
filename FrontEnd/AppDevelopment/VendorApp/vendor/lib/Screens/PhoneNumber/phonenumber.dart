import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Login/login.dart';
import '../Registeration/registeration.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  State<PhoneNumber> createState() => _MyAppState();

}

class _MyAppState extends State<PhoneNumber> {
  final TextEditingController phoneNumberController = TextEditingController();
  String selectedCountryCode = '+92';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: child!,
        );
      },

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
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
                    width: screenWidth,
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
                  left: screenWidth * 0.023,
                  top: screenHeight * 0.001,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.chevron_left_outlined,
                              size: screenWidth * 0.106, color: Colors.black),
                          SizedBox(
                            width: screenWidth * 0.012,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.39,
                  top: screenHeight * 0.01,
                  child: Text(
                    AppLocalizations.of(context)!.app_name,
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
                  left: screenWidth * 0.3,
                  top: screenHeight * 0.2,
                  child: Text(
                    AppLocalizations.of(context)!.enter_number,
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
                  left: screenWidth * 0.11,
                  top: screenHeight * 0.388,
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth * 0.07,
                          child: Image.asset(
                            "assets/images/pakistan.png",
                            width: screenWidth * 0.07,
                            height: screenHeight * 0.03,
                          ),
                        ),
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
                                    Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.045,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.45,
                          child: TextField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              hintText: '3144364288',
                              hintStyle: TextStyle(
                                fontSize: screenWidth * 0.048,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: screenWidth * 0.35,
                  top: screenHeight * 0.76,
                  child: GestureDetector(
                    onTap: () {
                      //To be checked against database to see which route happens
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         Login(phoneNumber: phoneNumberController.text),
                      //   ),
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Registeration(),
                        ),
                      );

                    },
                    child: Container(
                      width: screenWidth * 0.3,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF6FB457),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.next_button,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
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
