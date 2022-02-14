// @dart=2.9
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Category extends StatefulWidget {
  static String id = 'Category';

  const Category({Key key}) : super(key: key);

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'Collection',
            style: TextStyle(
                fontSize: 27, color: KAppColor, fontFamily: 'Raleway'),
          ),
          const SizedBox(
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
                  CustomLayoutOption(startIndex: -1, stateCount: 3)
                      .addRotate([0.0 / 180, 0.0, 0.0 / 180]).addTranslate([
                const Offset(-310.0, 0.0),
                const Offset(0.0, 0.0),
                const Offset(310.0, 0.0) //for right element
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
                      style: const TextStyle(
                          fontSize: 40,
                          color: KAppColor,
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
