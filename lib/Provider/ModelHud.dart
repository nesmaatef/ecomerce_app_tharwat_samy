import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier {
  bool isloading = false;
  changeisloading(bool value) {
    isloading = value;
    notifyListeners();
  }
}
