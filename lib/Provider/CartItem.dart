import 'package:ecomerce/Models/Products.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<products> product = [];
  add_product(products product1) {
    product.add(product1);
    notifyListeners();
  }

  clear() {
    product.clear();
    notifyListeners();
  }

  remove(products product1) {
    product.remove(product1);
    notifyListeners();
  }
}
