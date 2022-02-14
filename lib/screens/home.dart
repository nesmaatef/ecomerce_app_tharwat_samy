// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Provider/Favorite.dart';
import 'package:ecomerce/Services/Store.dart';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/product_info.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ecomerce/functions.dart';
import 'package:ecomerce/widgets/productview.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = 'Home';

  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final store = Store();
  String name;
  List<products> product11;
  int x = 0;

  @override
  void dispose() {
    super.dispose();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int tapbar_index;
  @override
  Widget build(BuildContext context) {
    final count = ModalRoute.of(context).settings.arguments;
    name = count;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 1,
                bottom: TabBar(
                  indicatorColor: Colors.red,
                  onTap: (value) {
                    setState(() {
                      tapbar_index = value;
                    });
                  },
                  tabs: [
                    Text(Kteshirt,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: tapbar_index == 0
                                ? KAppColor
                                : Color(0xFF707070),
                            fontSize: tapbar_index == 0 ? 16 : 14,
                          ),
                        )),
                    Text(Kshoes,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: tapbar_index == 1
                                ? KAppColor
                                : Color(0xFF707070),
                            fontSize: tapbar_index == 1 ? 16 : 14,
                          ),
                        )),
                  ],
                ),
              ),
              body: TabBarView(children: [
                Jacketview(),
                productview(Kshoes, product11),
              ])),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          child: Material(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
              child: Container(
                color: Colors.white,
                child: Text('Discover'.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: KAppColor,
                        fontSize: 20,
                      ),
                    )),
                height: MediaQuery.of(context).size.height * .1,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget Jacketview() {
    FavoriteItem favotite = Provider.of<FavoriteItem>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
      stream: store.load_product(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<products> product = [];
          for (var doc in snapshot.data.docs) {
            if (doc[KProductsex] == name) {
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
          }
          product11 = [...product];
          product.clear();
          product = getproductbycategory(Kteshirt, product11);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .7),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  color: Colors.white,
                  height: 100,
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Info.id,
                              arguments: product[index]);
                          // ignore: avoid_print
                          print(product[index].PId);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            height: MediaQuery.of(context).size.height * .23,
                            width: MediaQuery.of(context).size.width,
                            image: NetworkImage(product[index].pimage_location),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: .6,
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      product[index].pname,
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            favotite.add_product(
                                                product, product[index].PId);
                                          });
                                        },
                                        child: favotite.isfavorite(
                                                product, product[index].PId)
                                            ? const Icon(Icons.favorite,
                                                size: 30, color: KAppColor)
                                            : const Icon(Icons.favorite_border,
                                                size: 30, color: KAppColor)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('\$ ${product[index].pprice}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.red,
                                        fontFamily: 'Raleway')),
                              ],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: product.length,
            ),
          );
        } else {
          return const Center(
            child: Text('Loading.....'),
          );
        }
      },
    );
  }
}
