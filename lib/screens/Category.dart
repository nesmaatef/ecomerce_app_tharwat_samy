// @dart=2.9
import 'package:ecomerce/screens/CartScreen.dart';
import 'package:ecomerce/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Category extends StatefulWidget {
  static String id = 'Category';

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String name;

  final imageList = [
    'lib/images/1.jpg',
    'lib/images/men.png.jpg',
    'lib/images/woman.png.jpg'
  ];
  final imageList1 = ['children', 'men', 'women'];

  @override
  Widget build(BuildContext context) {
    double number = MediaQuery.of(context).size.height * 7;

    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFf1f0f2),
        animationCurve: Curves.linearToEaseOut,
        height: 50,
        items: <Widget>[
          Icon(
            Icons.view_quilt,
            size: 30,
            color: Color(0xFFFA4248),
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
      backgroundColor: Color(0xFFf1f0f2),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Collection',
            style: TextStyle(
                fontSize: 27, color: Color(0xFFFA4248), fontFamily: 'Raleway'),
          ),
          SizedBox(
            height: 30,
          ),
          Swiper(
              onTap: (index) {
                String count = imageList1[index];
                for (index = 0; index <= 2; index++) {
                  Navigator.pushNamed(context, Home.id, arguments: count);
                }
              },
              layout: SwiperLayout.CUSTOM,
              customLayoutOption:
                  new CustomLayoutOption(startIndex: -1, stateCount: 3)
                      .addRotate([0.0 / 180, 0.0, 0.0 / 180]).addTranslate([
                new Offset(-310.0, 0.0),
                new Offset(0.0, 0.0),
                new Offset(310.0, 0.0) //for right element
              ]),
              itemWidth: 280,
              itemHeight: MediaQuery.of(context).size.height * .6,
              //  itemHeight: 400,
              itemBuilder: (context, index) {
                return Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imageList[index],
                      height: number,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 70,
                    child: Text(
                      imageList1[index],
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFFFA4248),
                          fontFamily: 'Raleway'),
                    ),
                  )
                ]);
              },
              itemCount: imageList.length),
        ],
      ),
    );
  }
}
