import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../Utility/utility.dart';
import '../SelectLanguage/languageprovider.dart';
import '../Login/login.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Registration extends StatefulWidget {
  String phoneNumberController;

  Registration({required this.phoneNumberController});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deliveryAreasController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();


  bool agreeToTerms = false;
  String selectedCountryCode = '+92';
  String selectedArea = 'Dha';
  String? passwordError;
  bool showPassword = false;
  String usernameError = '';
  String usernameAvailabilityMessage = '';


  Future<String> checkUsernameAvailability(String username) async {
    final String url =
        "http://10.0.2.2:3000/api/user_table/usernameexists/$username";
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
      );
      final dynamic json = jsonDecode(response.body);
      bool usernameExists = json;

      return usernameExists
          ? "Username is already taken"
          : "Username is available";
    } catch (e) {
      return "Error checking username availability";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
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
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.chevron_left_outlined,
                                  size: screenWidth * 0.106,
                                  color: Colors.black),
                              SizedBox(
                                width: screenWidth * 0.012,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.34,
                        top: screenHeight * 0.00,
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
                        left: screenWidth * 0.15,
                        top: screenHeight * 0.07,
                        child: Text(
                          AppLocalizations.of(context)!.enter_reg_details,
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
                        top: screenHeight * 0.12,
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
                                  AppLocalizations.of(context)!.phone_number,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text(
                                        '+92',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: screenWidth * 0.6,
                                      child: Text(
                                        '${widget.phoneNumberController}',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.23,
                        child: Text(
                          AppLocalizations.of(context)!.password,
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
                        top: screenHeight * 0.25,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: passwordController,
                                obscureText: !showPassword,
                                onChanged: (value) {
                                  validatePassword();
                                },
                                decoration: InputDecoration(
                                  errorText: passwordError,
                                  hintText: AppLocalizations.of(context)!
                                      .enter_password,
                                  hintStyle: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.34,
                        child: Text(
                          AppLocalizations.of(context)!.confirm_password,
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
                        top: screenHeight * 0.36,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: confirmPasswordController,
                            obscureText: !showPassword,
                            onChanged: (value) {
                              validatePassword();
                            },
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.enter_password,
                              hintStyle: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w400,
                              ),
                              hintMaxLines: 1,
                              suffixIcon: Icon(
                                Icons.check,
                                color:
                                    _isPasswordValid(passwordController.text) &&
                                            passwordController.text ==
                                                confirmPasswordController.text
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.45,
                        child: Text(
                          AppLocalizations.of(context)!.full_name,
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
                        top: screenHeight * 0.47,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: nameController,
                            obscureText: false,
                            onChanged: (value) {
                              validateName(value);
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.full_name,
                              hintStyle: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w400,
                              ),
                              errorText: nameController.text.isNotEmpty &&
                                      !isNameValid(nameController.text)
                                  ? 'Name can only contain alphabets'
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.56,
                        child: Text(
                          AppLocalizations.of(context)!.username,
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
                        top: screenHeight * 0.58,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: userNameController,
                            obscureText: false,
                            onTap: () {
                              if (userNameController.text.isNotEmpty &&
                                  !isUsernameValid(userNameController.text)) {
                                setState(() {
                                  usernameError =
                                      'Username must start with alphabets';
                                });
                              } else {
                                setState(() {
                                  usernameError = '';
                                });
                              }
                            },
                            onChanged: (value) {
                              if (userNameController.text.isNotEmpty &&
                                  !isUsernameValid(userNameController.text)) {
                                setState(() {
                                  usernameError =
                                      'Username must start with alphabets';
                                });
                              } else {
                                setState(() {
                                  usernameError = '';
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.username,
                              hintStyle: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w400,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: userNameController.text.isEmpty
                                      ? Colors.blue
                                      : usernameError.isNotEmpty
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: userNameController.text.isEmpty
                                      ? Colors.grey
                                      : usernameError.isNotEmpty
                                          ? Colors.red
                                          : Colors.green,
                                ),
                              ),
                              errorText: usernameError.isNotEmpty
                                  ? usernameError
                                  : null,
                              errorStyle: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.67,
                        child: Text(
                          AppLocalizations.of(context)!.delivery_areas,
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
                        top: screenHeight * 0.71,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: DropdownButton<String>(
                            value: selectedArea,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedArea = newValue!;
                              });
                            },
                            items: <String>['Dha', 'State Life', 'Gulberg']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: screenHeight * 0.8,
                        child: Container(
                          width: screenWidth * 0.9,
                          child: Align(
                            alignment: Alignment.center,
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
                                    text: AppLocalizations.of(context)!
                                        .i_agree_to,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .terms_and_conditions,
                                        style: TextStyle(
                                          color: Color(0xFF6FB457),
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!.and,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .privacy_and_policy,
                                        style: TextStyle(
                                          color: Color(0xFF6FB457),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.89,
                        left: screenWidth * 0.30,
                        bottom: screenHeight * 0.05,
                        child: GestureDetector(
                          onTap: () async {
                            bool isAnyFieldEmpty = false;

                            // Check if any field is empty
                            if (nameController.text.isEmpty ||
                                userNameController.text.isEmpty ||
                                !agreeToTerms) {
                              isAnyFieldEmpty = true;
                              setState(() {
                                usernameError = 'Please fill all required fields.';
                              });
                            } else {
                              setState(() {
                                usernameError = ''; // Clear any previous error messages
                              });

                              // Check if the username is available only if all fields are filled
                              String availabilityMessage =
                              await checkUsernameAvailability(userNameController.text);

                              if (availabilityMessage == "Username is available" &&
                                  _isPasswordValid(passwordController.text) &&
                                  _isPasswordValid(confirmPasswordController.text) &&
                                  passwordController.text == confirmPasswordController.text) {
                                // Register the user
                                createUser(
                                  widget.phoneNumberController,
                                  nameController.text,
                                  passwordController.text,
                                  userNameController.text,
                                  "English",
                                  "Vendor",
                                  selectedArea,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(
                                      phoneNumber: widget.phoneNumberController,
                                    ),
                                  ),
                                );
                              } else {
                                setState(() {
                                  if (!_isPasswordValid(passwordController.text)) {
                                    passwordError =
                                    "Password must be 8 characters long and contain special characters";
                                  }
                                  if (passwordController.text != confirmPasswordController.text) {
                                    passwordError = "Passwords do not match";
                                  }
                                  usernameError = "Username is already taken";
                                });
                              }
                            }
                          },
                          child: IgnorePointer(
                            ignoring: !agreeToTerms ||
                                !isNameValid(nameController.text) ||
                                userNameController.text.isEmpty ||
                                passwordController.text.length < 8 ||
                                !_isPasswordValid(passwordController.text) ||
                                confirmPasswordController.text.length < 8 || // New check
                                !_isPasswordValid(confirmPasswordController.text) || // New check
                                passwordController.text != confirmPasswordController.text, // New check
                            child: Opacity(
                              opacity: agreeToTerms &&
                                  isNameValid(nameController.text) &&
                                  userNameController.text.isNotEmpty &&
                                  passwordController.text.length >= 8 &&
                                  _isPasswordValid(passwordController.text) &&
                                  confirmPasswordController.text.length >= 8 && // New check
                                  _isPasswordValid(confirmPasswordController.text) && // New check
                                  passwordController.text == confirmPasswordController.text // New check
                                  ? 1.0
                                  : 0.5,
                              child: Container(
                                width: screenWidth * 0.3,
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF6FB457),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.register,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void validatePassword() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    bool isPasswordValid = _isPasswordValid(password);
    setState(() {
      passwordError = isPasswordValid
          ? null
          : "Password must be 8 characters long and contain special characters";
    });
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8 &&
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
  }

  void validateName(String name) {
    setState(() {
      if (name.isNotEmpty && !isNameValid(name)) {
        nameController.text = '';
      }
    });
  }

  bool isNameValid(String name) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  }

  bool isUsernameValid(String username) {
    return RegExp(r'^[a-zA-Z]').hasMatch(username);
  }
}
