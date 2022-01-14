import 'package:ecomerce/Models/Products.dart';

List<products> getproductbycategory(
    String Kteshirt, List<products> allproduct) {
  List<products> product = [];
  try {
    if (product != null) {
      for (var product1 in allproduct) {
        if (product1.pcategory == Kteshirt) {
          product.add(product1);
        }
      }
    }
  } catch (ex) {
    print(ex);
  }
  return product;
}
