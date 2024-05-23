import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _userId = '';
  String _vendorId = '';

  String get userId => _userId;
  String get vendorId => _vendorId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setVendorId(String vendorId) {
    _vendorId = vendorId;
    notifyListeners();
  }
}
