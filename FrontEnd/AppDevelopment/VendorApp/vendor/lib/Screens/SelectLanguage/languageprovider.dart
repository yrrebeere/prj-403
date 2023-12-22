import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _selectedLocale = Locale('en'); // Default language is English

  Locale get selectedLocale => _selectedLocale;

  void setSelectedLocale(Locale locale) {
    _selectedLocale = locale;
    notifyListeners();
  }
}
