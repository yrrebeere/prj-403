import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../Classes/api.dart';
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
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController storeAddressController = TextEditingController();
  // final TextEditingController deliveryAreasController = TextEditingController();

  bool agreeToTerms = false;
  String selectedCountryCode = '+92';
  String? passwordError;
  bool showPassword = false;
  String usernameError = '';
  String usernameAvailabilityMessage = '';

  String? _imageExtension;
  File? _imageFile;
  final picker = ImagePicker();

  Future<void> _chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _imageExtension = path.extension(pickedFile.path).toLowerCase();
      }
      else {
        print('No image selected.');
      }
    });
  }

  Future<void> _uploadImage(String storeName) async {
    if (_imageFile == null) {
      print('No image selected.');
      return;
    }

    String apiUrl = '${ApiConstants.baseUrl}/api/image/uploadstore?store_name=$storeName';

    try {
      var uri = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', uri);

      request.files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      print('Image upload failed with error: $e');
    }
  }

  Future<String> checkUsernameAvailability(String username) async {
    final String url =
        "${ApiConstants.baseUrl}/api/user_table/usernameexists/$username";
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

  Future<void> createUser(
      String phoneNumber,
      String name,
      String password,
      String username,
      String language,
      String userType,
      String storeName,
      String storeAddress
      ) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/user_table/adduser'),
      body: jsonEncode({
        'phone_number': phoneNumber,
        'name': name,
        'password': password,
        'username': username,
        'language': language,
        'user_type': userType,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    _uploadImage(username);

    if (response.statusCode == 201) {
      print("User added");
      final dynamic json = jsonDecode(response.body);

      print(json);

      await createStore(storeName, storeAddress, json['user_id'], json['username']);
    } else {
      throw Exception('Failed to add user');
    }
  }

  Future<void> createStore(String storeName, String storeAddress, int userId, String username) async {

    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/grocery_store/addstore'),
      body: jsonEncode({
        'store_name': storeName,
        'store_address': storeAddress,
        'user_table_user_id': userId,
        'image': 'stores/' + username + _imageExtension!,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      print("Store added");
    } else {
      throw Exception('Failed to add store');
    }
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
                                    size: screenWidth * 0.106, color:Color(0xFF6FB457)),
                                SizedBox(
                                  width: screenWidth * 0.012,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: screenWidth * 0.2,
                        top: screenHeight * 0.07,
                        child: Text(
                          AppLocalizations.of(context)!.enter_reg_details,
                          style: TextStyle(
                            color: Color(0xFF6FB457),
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * 0.0,
                        top: screenHeight * 0.16,
                        child: Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.08,
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
                                    fontSize: screenWidth * 0.036,
                                    fontWeight: FontWeight.w400,
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
                        top: screenHeight * 0.25,
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
                        top: screenHeight * 0.27,
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
                        top: screenHeight * 0.44,
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
                        top: screenHeight * 0.46,
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
                        top: screenHeight * 0.54,
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
                        top: screenHeight * 0.56,
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
                        top: screenHeight * 0.645,
                        child: Text(
                          AppLocalizations.of(context)!.store_name,
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
                        top: screenHeight * 0.672,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: storeNameController,
                            obscureText: false,
                            onChanged: (value) {
                              validateName(value);
                            },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.store_name,
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
                        top: screenHeight * 0.74,
                        child: Text(
                          AppLocalizations.of(context)!.store_address,
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
                        top: screenHeight * 0.77,
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            controller: storeAddressController,
                            obscureText: false,
                            // onChanged: (value) {
                            //   validateName(value);
                            // },
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.store_address,
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
                        top: screenHeight * 0.85,
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
                        top: screenHeight * 0.93,
                        left: screenWidth * 0.10,
                        bottom: screenHeight * 0.01,
                          child: ElevatedButton(
                            onPressed: _chooseImage,
                            child: Text('Select Image'),
                          ),
                      ),
                      Positioned(
                        top: screenHeight * 0.93,
                        left: screenWidth * 0.50,
                        bottom: screenHeight * 0.01,
                        child: GestureDetector(
                          onTap: () async {
                            await handleRegistration();
                            print('Button clicked'); // Print this line for debugging
                          },
                          child: IgnorePointer(
                            ignoring: !agreeToTerms ||
                                !isNameValid(nameController.text) ||
                                userNameController.text.isEmpty ||
                                passwordController.text.length < 8 ||
                                !_isPasswordValid(passwordController.text) ||
                                confirmPasswordController.text.length <
                                    8 || // New check
                                !_isPasswordValid(confirmPasswordController
                                    .text) || // New check
                                passwordController.text !=
                                    confirmPasswordController.text, // New check
                            child: Opacity(
                              opacity: agreeToTerms &&
                                  isNameValid(nameController.text) &&
                                  userNameController.text.isNotEmpty &&
                                  passwordController.text.length >= 8 &&
                                  _isPasswordValid(
                                      passwordController.text) &&
                                  confirmPasswordController.text.length >=
                                      8 && // New check
                                  _isPasswordValid(confirmPasswordController
                                      .text) && // New check
                                  passwordController.text ==
                                      confirmPasswordController
                                          .text // New check
                                  ? 1.0
                                  : 0.5,
                              child: Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.3,
                                    // padding: const EdgeInsets.all(14.0),
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
                                ],
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

  Future<void> handleRegistration() async {
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
        usernameError = '';
      });

      String availabilityMessage =
      await checkUsernameAvailability(userNameController.text);

      if (availabilityMessage == "Username is available" &&
          _isPasswordValid(passwordController.text) &&
          _isPasswordValid(confirmPasswordController.text) &&
          passwordController.text == confirmPasswordController.text) {
        // Register the user
        await createUser(
          widget.phoneNumberController!,
          nameController.text,
          passwordController.text,
          userNameController.text,
          "English",
          "Grocery Store",
          storeNameController.text,
          storeAddressController.text
        );
        // Navigate to the login screen
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login(
                phoneNumber: widget.phoneNumberController!,
                // Include the userId if you have it),
              ),
            ));
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
