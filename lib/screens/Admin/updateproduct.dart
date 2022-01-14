// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Services/Store.dart';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/Admin/Editproductscreen.dart';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Update_Product extends StatefulWidget {
  static String id = 'UpdateProduct';

  const Update_Product({Key key}) : super(key: key);

  @override
  _Update_ProductState createState() => _Update_ProductState();
}

class _Update_ProductState extends State<Update_Product> {
  final store = Store();
  List<products> product11;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.load_product(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<products> product = [];
            for (var doc in snapshot.data.docs) {
              Map data = doc.data();
              product.add(products(
                PId: doc.id,
                pprice: data[KProductprice],
                pname: data[KProductname],
                pimage_location: data[KProductlocation],
                pcategory: data[KProductcategory],
                pdescription: data[KProductdscription],
              ));
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTapUp: (details) {
                    double dx = details.globalPosition.dx;
                    double dy = details.globalPosition.dy;
                    double dx1 = MediaQuery.of(context).size.width - dx;
                    double dy1 = MediaQuery.of(context).size.width - dy;

                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                        items: [
                          MypopupMenuItem(
                            onclick: () {
                              Navigator.pushNamed(context, Edit_product.id,
                                  arguments: product[index]);
                            },
                            child: Text('Update'),
                          ),
                          MypopupMenuItem(
                            onclick: () {
                              store.Deleteproduct(product[index].PId);
                            },
                            child: Text('Delete'),
                          ),
                        ]);
                  },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fill,
                          image: NetworkImage(product[index].pimage_location),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product[index].pname,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text('\$ ${product[index].pprice}'),
                                ],
                              ),
                            ),
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            height: 60,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              itemCount: product.length,
            );
          } else {
            return Center(
              child: Text('Loading.....'),
            );
          }
        },
      ),
    );
  }
}

class MypopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onclick;
  MypopupMenuItem({this.child, this.onclick}) : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MypopupMenuItemState();
  }
}

class MypopupMenuItemState<T, PopupMenuItem>
    extends PopupMenuItemState<T, MypopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onclick();
  }
}
