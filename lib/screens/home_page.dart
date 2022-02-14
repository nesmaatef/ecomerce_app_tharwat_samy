import 'dart:ui';

import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/category.dart';
import 'package:ecomerce/screens/cart_screen.dart';
import 'package:ecomerce/screens/FavoriteScreen.dart';
import 'package:ecomerce/screens/SearchScreen.dart';
import 'package:ecomerce/screens/main_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = 'Home page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const MainHome(),
    FavoriteScreen(),
    SearchScreen(),
    Category(),
    const Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: pageIndex,
          children: pages,
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              selectedItemColor: KAppColor,
              unselectedItemColor: Colors.black54,
              currentIndex: pageIndex,
              onTap: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 30,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: KAppColor, fontSize: 14),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 30,
                    ),
                    title: Text(
                      'Favourite',
                      style: TextStyle(color: KAppColor, fontSize: 14),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    title: Text(
                      'Search',
                      style: TextStyle(color: KAppColor, fontSize: 14),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.category_outlined,
                      size: 30,
                    ),
                    title: Text(
                      'Category',
                      style: TextStyle(color: KAppColor, fontSize: 14),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 30,
                    ),
                    title: Text(
                      'Cart',
                      style: TextStyle(color: KAppColor, fontSize: 14),
                    ))
              ],
            ),
          ),
        ));
  }
}
