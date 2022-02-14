// @dart=2.9
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Services/Store.dart';
import 'package:ecomerce/consts.dart';
import 'package:flutter/material.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key key}) : super(key: key);
  static String id = 'Home page';
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  final store = Store();
  List<products> product11;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Icon(
                Icons.search,
                color: Colors.black87,
              ),
            ),
          ],
          title: const Center(
            child: Text(
              'Discover',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: CarouselSlider(
                items: [
                  //1st Image of Slider
                  SliderContainer(),

                  //2nd Image of Slider
                  SliderContainer(),

                  //3rd Image of Slider
                  SliderContainer(),

                  //4th Image of Slider
                  SliderContainer(),

                  //5th Image of Slider
                  SliderContainer(),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 1.0,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: .8),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: GestureDetector(
                          onTapUp: (details) {},
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image(
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      product[index].pimage_location),
                                ),
                              ),
                              Positioned(
                                bottom: -2,
                                child: Opacity(
                                  opacity: .6,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product[index].pname,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '\$ ${product[index].pprice}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: KAppColor),
                                          ),
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
                    return const Center(
                      child: Text('Loading.....'),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget SliderContainer() {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: const DecorationImage(
          image: NetworkImage(
              "https://cdn.grabon.in/gograbon/images/web-images/uploads/1617875488697/clothing-offers.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
