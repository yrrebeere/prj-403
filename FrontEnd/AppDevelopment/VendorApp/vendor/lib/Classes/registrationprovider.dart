import 'package:flutter/material.dart';

class UserIdProvider extends ChangeNotifier {
  int? _userId;

  int? get userId => _userId;

  void setUserId(int? userId) {
    _userId = userId;
    notifyListeners();
  }
}
