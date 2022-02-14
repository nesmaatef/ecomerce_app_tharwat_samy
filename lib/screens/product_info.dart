// @dart=2.9
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Provider/CartItem.dart';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Info extends StatefulWidget {
  static String id = 'Info';

  const Info({Key key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    products product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              child: Image.network(
                product.pimage_location,
                fit: BoxFit.fill,
              )),
          Opacity(
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                  boxShadow: const [
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
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: const Icon(Icons.add)),
                        const SizedBox(
                          width: 40,
                        ),
                        Builder(builder: (context) {
                          return FlatButton(
                            onPressed: () {
                              Addtocart(context, product);
                            },
                            color: KAppColor,
                            minWidth: 150,
                            height: 40,
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          );
                        }),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            child: const Icon(Icons.minimize)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.pname,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.pdescription,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120, left: 280),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: KAppColor),
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
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
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: KAppColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 2,
                      offset: Offset(4, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('you \'ve  Added to cart')));
    } else {
      cartitem.add_product(product);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Added to cart')));
    }
  }
}
