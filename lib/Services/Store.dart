// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/consts.dart';

class Store {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  addproduct(products product) {
    firestore.collection(KProductcollection).add({
      KProductname: product.pname,
      KProductprice: product.pprice,
      KProductcategory: product.pcategory,
      KProductdscription: product.pdescription,
      KProductlocation: product.pimage_location,
      KProductsex: product.Psex,
    });
  }

  Stream<QuerySnapshot> load_product() {
    return firestore.collection(KProductcollection).snapshots();
  }

  Stream<QuerySnapshot> load_product1() {
    return firestore.collection(KProductcollection).snapshots();
  }

  Deleteproduct(docId) {
    firestore.collection(KProductcollection).doc(docId).delete();
  }

  EditProduct(data, documentid) {
    firestore.collection(KProductcollection).doc(documentid).update(data);
  }
}
