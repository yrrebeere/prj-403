import 'package:flutter/material.dart';

class PhoneNumberProvider extends ChangeNotifier {
  late String _phoneNumber;

  String get phoneNumber => _phoneNumber;

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }
}
