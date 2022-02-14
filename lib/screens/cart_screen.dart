// @dart=2.9
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Provider/CartItem.dart';
import 'package:ecomerce/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  static String id = 'Cart';

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity;
  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    List<products> product1 = Provider.of<CartItem>(context).product;
    var price1 = calcprice(product1);
    // ignore: avoid_print
    print(quantity);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                // go to complete order
              },
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          title: const Center(
              child: Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 20,
              color: KAppColor,
            ),
          )),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            LayoutBuilder(builder: (context, constrains) {
              if (product1.isNotEmpty) {
                return SizedBox(
                  height: screenheight * .65,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      quantity = product1[index].Pquantity;
                      return Row(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: screenheight * .16,
                          width: screenwidth,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.5),
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.black12,
                                  width: 120,
                                  child: Image.network(
                                      product1[index].pimage_location),
                                ),
                                // here as be continu !!!!!!!!!!!!
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      product1[index].pname,
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: KAppColor,
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          '$quantity',
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (quantity > 1) {
                                                    quantity--;
                                                  }
                                                });
                                              },
                                              child: const Icon(Icons.minimize,
                                                  color: KAppColor)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      '\$ ${product1[index].pprice}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: KAppColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      color: KAppColor,
                                      child: GestureDetector(
                                        onTap: () {
                                          CartItem cartitem =
                                              Provider.of<CartItem>(context,
                                                  listen: false);
                                          cartitem.remove(product1[index]);
                                        },
                                        child: const Icon(
                                          Icons.delete_forever,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]);
                    },
                    itemCount: product1.length,
                  ),
                );
              } else {
                return const Center(
                    child: Text(
                  'Cart is empty now',
                  style: TextStyle(fontSize: 20),
                ));
              }
            }),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                  color: KAppColor, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ToTal',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    '\$ $price1',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  calcprice(List<products> product1) {
    var price = 0;
    for (var product in product1) {
      price += product.Pquantity * int.parse(product.pprice);
    }
    return price;
  }
}

/*
else {
                      return Center(
                          child: Text(
                        'Cart is empty now',
                        style: TextStyle(fontSize: 20),
                      ));
                    }*/
