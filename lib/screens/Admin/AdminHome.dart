// @dart=2.9
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/Admin/AddProduct.dart';
import 'package:ecomerce/screens/Admin/updateproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AdminHome extends StatefulWidget {
  static String id = 'AdminHome';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List name = ['Add Product', 'Manage Product', 'Orders'];
  List images = [
    'lib/images/add-to-basket.png',
    'lib/images/manager.png',
    'lib/images/order.png'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF3d1308),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Color(0xFF3d1308),
              //  alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Superstore',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Hi Admin',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(15),
                crossAxisCount: 2,
                childAspectRatio: 10 / 9,
                children: List.generate(3, (index) {
                  return GridTile(
                      child: GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.pushNamed(context, AddProduct.id);
                      } else if (index == 1) {
                        Navigator.pushNamed(context, UpdateProduct.id);
                      } else if (index == 2) {
                        // Navigator.pushNamed(context, Update_Product.id);
                      }
                    },
                    child: Card(
                      color: Colors.white.withOpacity(.25),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: 70,
                              height: 70,
                              child: Image.asset(
                                images[index],
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            name[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ));
                }),
              ),
            )
            /*
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              color: Colors.blueGrey,
              textColor: Colors.white,
              child: Text('Add Product'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Update_Product.id);
              },
              color: Colors.blueGrey,
              textColor: Colors.white,
              child: Text('manage product'),
            ),
            RaisedButton(
              color: Colors.blueGrey,
              textColor: Colors.white,
              child: Text('order screen'),
            ),

             */
          ],
        ),
      ),
    );
  }
}
