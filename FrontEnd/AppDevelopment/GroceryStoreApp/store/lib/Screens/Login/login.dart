import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:store/Screens/NavigationBar/navbar.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../PhoneNumber/phonenumberprovider.dart';
import '../Registration/registrationprovider.dart';
import '../SelectLanguage/languageprovider.dart';

class Login extends StatefulWidget {
  final String phoneNumber;
  final int? userId;

  const Login({Key? key, required this.phoneNumber, this.userId}) : super(key: key);

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    if (widget.userId != null) {
      // Handle the user ID, for example, store it in a provider
      final userIdProvider = Provider.of<UserIdProvider>(context, listen: false);
      userIdProvider.setUserId(widget.userId); // Convert int to String
    }

    Future.delayed(Duration.zero, () {
      Provider.of<PhoneNumberProvider>(context, listen: false)
          .setPhoneNumber(widget.phoneNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageProvider.selectedLocale,
            builder: (context, child) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: child!,
              );
            },
            home: Scaffold(

              body: SafeArea(
                child: Builder(
                  builder: (BuildContext builderContext) {
                    return Form(
                      key: _formKey,
                      child: Container(
                        width: screenWidth * 1,
                        height: screenHeight * 1,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Colors.white),
                        child: SingleChildScrollView(
                            child: Container(
                              width: screenWidth * 1,
                              height: screenHeight * 1,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(color: Colors.white),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: screenWidth * 0.023,
                                    top: screenHeight * 0.04,
                                    child: Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.chevron_left_outlined,
                                                size: screenWidth * 0.106, color: Color(0xFF6FB457)),
                                            SizedBox(
                                              width: screenWidth * 0.012,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.38,
                                    top: screenHeight * 0.1,
                                    child: Text(
                                      AppLocalizations.of(context)!.app_name,
                                      style: TextStyle(
                                        color: Color(0xFF6FB457),
                                        fontSize: 32,
                                        fontFamily: 'Inter',
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: screenHeight * 0.2,
                                    child: Container(
                                      width: screenWidth * 1.0,
                                      height: screenHeight * 0.58,
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
                                    left: screenWidth * 0.13,
                                    top: screenHeight * 0.39,
                                    child: Text(
                                      AppLocalizations.of(context)!.phone_number,
                                      style: TextStyle(
                                        color: Color(0xFF6FB457),
                                        fontSize: screenWidth * 0.05,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.43,
                                    top: screenHeight * 0.22,
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style: TextStyle(
                                        color: Color(0xFF6FB457),
                                        fontSize: screenWidth * 0.07,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.10,
                                    top: screenHeight * 0.42,
                                    child: Container(
                                      width: screenWidth * 0.800,
                                      height: screenHeight * 0.06,
                                      padding: EdgeInsets.all(8.0),

                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Color(0xFF6FB457),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Directionality(
                                                  textDirection: TextDirection.ltr,
                                                  child: Text(
                                                    '0${widget.phoneNumber}',
                                                    style: TextStyle(
                                                      fontSize: screenWidth * 0.040,
                                                      fontFamily: 'Inter',
                                                      fontWeight: FontWeight.w400,
                                                      color: Color(0xFF6FB457),
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: screenHeight * 0.08),
                                      child: SizedBox(
                                          width: screenWidth * 0.800,
                                          height: screenHeight * 0.06,
                                          child: Directionality(
                                            textDirection: TextDirection.ltr,
                                            child:
                                            TextFormField(
                                              controller: passwordController,
                                              obscureText: !showPassword, // Use the showPassword variable to toggle visibility
                                              decoration: InputDecoration(
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xFF6FB457)),
                                                ),
                                                enabledBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Color(0xFF6FB457)),
                                                ),
                                                filled: true,
                                                prefixIcon: Icon(
                                                  Icons.lock,
                                                  color: Color(0xFF6FB457),
                                                ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    showPassword ? Icons.visibility : Icons.visibility_off,
                                                    color: Color(0xFF6FB457),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      showPassword = !showPassword; // Toggle showPassword
                                                    });
                                                  },
                                                ),
                                                hintText: AppLocalizations.of(context)!.enter_password,
                                                suffixStyle: TextStyle(
                                                  fontSize: screenWidth * 0.040,
                                                ),
                                                hintStyle: TextStyle(color: Color(0xFF6FB457)),
                                              ),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Password is required';
                                                } else if (value.length < 8) {
                                                  return 'Password should be at least 8 digits long';
                                                } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                                                  return 'Password should contain at least one special character';
                                                }
                                                return null;
                                              },
                                            ),


                                          )),
                                    ),
                                  ),
                                  Positioned(
                                    left: screenWidth * 0.4,
                                    top: screenHeight * 0.68,
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if (_formKey.currentState!.validate()) {
                                          String password = passwordController.text;
                                          Navigator.push(
                                            builderContext,
                                            MaterialPageRoute(
                                              builder: (context) => NavBar(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF007AFF),
                                          borderRadius: BorderRadius.circular(
                                              screenHeight * 0.03),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF6FB457),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.login,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
