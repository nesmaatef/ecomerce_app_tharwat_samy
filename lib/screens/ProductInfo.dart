// @dart=2.9
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Provider/CartItem.dart';
import 'package:ecomerce/screens/CartScreen.dart';
import 'package:ecomerce/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  static String id = 'Info';

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    products product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFFA4248),
        animationCurve: Curves.linearToEaseOut,
        height: 50,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Cart.id);
              },
              child: Icon(Icons.shopping_cart, size: 30, color: Colors.black)),
          Icon(Icons.search, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 40),
                      child: Image.network(
                        product.pimage_location,
                        fit: BoxFit.fill,
                      )),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Opacity(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .4,
                      decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 4,
                              offset: Offset(4, 5),
                            ),
                          ],
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity++;
                                      });
                                    },
                                    child: Icon(Icons.add)),
                                SizedBox(
                                  width: 40,
                                ),
                                Builder(builder: (context) {
                                  return FlatButton(
                                    onPressed: () {
                                      Addtocart(context, product);
                                    },
                                    color: Color(0xFFFA4248),
                                    minWidth: 150,
                                    height: 40,
                                    child: Text(
                                      'Add to cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  );
                                }),
                                SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (quantity > 1) quantity--;
                                      });
                                    },
                                    child: Icon(Icons.minimize)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.pname,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.pdescription,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50, left: 280),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFA4248)),
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    opacity: .8,
                  ),
                ),
                //Padding(
                //padding: const EdgeInsets.only(top: 650),
                //child:

                //  )
              ],
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  color: Color(0xFFFA4248),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(4, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Continue Shopping',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void Addtocart(context, product) {
    bool exist = false;
    CartItem cartitem = Provider.of<CartItem>(context, listen: false);
    product.Pquantity = quantity;
    var productincart = cartitem.product;
    for (var productincart in productincart) {
      if (productincart == product) {
        exist == true;
      }
    }
    if (exist) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('you \'ve  Added to cart')));
    } else {
      cartitem.add_product(product);

      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Added to cart')));
    }
  }
}
