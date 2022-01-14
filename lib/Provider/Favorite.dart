import 'package:ecomerce/Models/Products.dart';
import 'package:flutter/cupertino.dart';

class FavoriteItem extends ChangeNotifier {
  List<products> product = [];
  List<products> favorites = [];

  add_product(product, String product_id) {
    var existindex =
        favorites.indexWhere((element) => element.PId == product_id);
    if (existindex >= 0) {
      favorites.removeAt(existindex);
    } else {
      favorites.add(product.firstWhere((element) => element.PId == product_id));
    }

    notifyListeners();
  }

  bool isfavorite(product, String product_id) {
    return favorites.any((element) => element.PId == product_id);
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
