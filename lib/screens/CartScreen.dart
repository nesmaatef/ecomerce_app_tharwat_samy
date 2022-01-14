// @dart=2.9
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Provider/CartItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ecomerce/Provider/CartItem.dart';

class Cart extends StatefulWidget {
  static String id = 'Cart';

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity;
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    List<products> product1 = Provider.of<CartItem>(context).product;
    var price1 = calcprice(product1);
    print(quantity);
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xFFf1f0f2).withOpacity(.5),
          animationCurve: Curves.linearToEaseOut,
          height: 50,
          items: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.home,
                size: 30,
                color: Color(0xFFFA4248),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Cart.id);
                },
                child: Icon(Icons.shopping_cart,
                    size: 30, color: Color(0xFFFA4248))),
            Icon(Icons.search, size: 30, color: Color(0xFFFA4248)),
            Icon(Icons.favorite, size: 30, color: Color(0xFFFA4248)),
          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                // go to complete order
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFFFA4248),
            ),
          )),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              LayoutBuilder(builder: (context, constrains) {
                if (product1.isNotEmpty) {
                  return Container(
                    height: screenheight * .5,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        quantity = product1[index].Pquantity;
                        return Container(
                            child: Row(children: [
                          SizedBox(
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        product1[index].pname,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
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
                                              child: Icon(
                                                Icons.add,
                                                color: Color(0xFFFA4248),
                                              )),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            '$quantity',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (quantity > 1)
                                                      quantity--;
                                                  });
                                                },
                                                child: Icon(Icons.minimize,
                                                    color: Color(0xFFFA4248))),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Text(
                                        '\$ ${product1[index].pprice}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFFFA4248),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Color(0xFFFA4248),
                                        child: GestureDetector(
                                          onTap: () {
                                            CartItem cartitem =
                                                Provider.of<CartItem>(context,
                                                    listen: false);
                                            cartitem.remove(product1[index]);
                                          },
                                          child: Icon(
                                            Icons.delete_forever,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]));
                      },
                      itemCount: product1.length,
                    ),
                  );
                } else {
                  return Center(
                      child: Text(
                    'Cart is empty now',
                    style: TextStyle(fontSize: 20),
                  ));
                }
              }),
              Spacer(),
              Container(
                width: 200,
                height: 50,
                decoration: new BoxDecoration(
                    color: Color(0xFFFA4248),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ToTal',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '\$ ${price1}',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              /*   Container(
                color: Colors.white,
                height: screenheight * .3,
                width: screenwidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total',
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'SubTotal',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '15\$',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*  RaisedButton(
                      color: Colors.deepOrange,
                      child: Text(
                        'Clear',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: () {
                        CartItem cartitem =
                            Provider.of<CartItem>(context, listen: false);
                        cartitem.clear();

                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('clear cart')));
                      },
                    ),*/ //  button to clean all data
                  ],
                ),
              ),*/
            ],
          ),
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
