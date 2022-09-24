import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage {
    return _selectedPage;
  }
  set selectedPage(int value) {
    _selectedPage = value;
    notifyListeners();
  }
}