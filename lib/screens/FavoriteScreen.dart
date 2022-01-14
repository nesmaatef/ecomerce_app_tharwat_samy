import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Provider/Favorite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class FavoriteScreen extends StatefulWidget {
   static String id = 'FavoriteScreen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
     final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    List<products> product1 = Provider.of<FavoriteItem>(context).product;
    return Scaffold(
        backgroundColor: Colors.white,
       appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            'Favorites',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
              fontSize: 20,
              color: Color(0xFFFA4248),
            ),)
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
                                  Text(
                                    product1[index].pname,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),

                                  Spacer(),

                                  Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                        child: GestureDetector(
                                          onTap: () {
                                            FavoriteItem favoriteItem =
                                                Provider.of<FavoriteItem>(context,
                                                    listen: false);
                                            favoriteItem.remove(product1[index]);
                                          },
                                          child: Icon(
                                            Icons.favorite_outlined,
                                            color:  Color(0xFFFA4248),
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
                    'Favorite List is empty now',
                    style: TextStyle(fontSize: 20),
                  ));
                }
              }),
            ],
          ),
        ));
  }
}
