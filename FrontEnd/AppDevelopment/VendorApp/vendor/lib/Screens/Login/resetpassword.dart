import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String newPasswordError = '';
  String confirmPasswordError = '';
  bool showPassword = false;

  void _resetPassword() {
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    // Basic validation
    if (newPassword.isEmpty) {
      setState(() {
        newPasswordError = 'Please enter a new password';
      });
      return;
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = 'Please confirm your new password';
      });
      return;
    }

    if (newPassword.length < 8 || !hasSpecialCharacter(newPassword)) {
      setState(() {
        newPasswordError =
        'Password must be at least 8 characters long and contain special characters';
      });
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      return;
    }

    // Resetting errors if validation passes
    setState(() {
      newPasswordError = '';
      confirmPasswordError = '';
    });

    // TODO: Implement password reset logic here
  }

  bool hasSpecialCharacter(String value) {
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6FB457),
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Text('WASAIL'),
        ),
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: newPasswordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                errorText: newPasswordError.isNotEmpty ? newPasswordError : null,
                suffixIcon: IconButton(
                  icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: confirmPasswordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                errorText: confirmPasswordError.isNotEmpty ? confirmPasswordError : null,
                suffixIcon: confirmPasswordError.isEmpty
                    ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
                    : Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _resetPassword,
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}
