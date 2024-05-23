import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  String _userId = '';
  String _storeId = '';

  String get userId => _userId;
  String get storeId => _storeId;

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }

  void setStoreId(String storeId) {
    _storeId = storeId;
    notifyListeners();
  }
}
