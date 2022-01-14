import 'package:flutter/material.dart';

class AdminMode extends ChangeNotifier {
  bool isAdmin = false;
  changeisadmin(bool value) {
    isAdmin = value;
    notifyListeners();
  }
}
