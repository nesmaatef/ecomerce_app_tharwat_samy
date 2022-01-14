// @dart=2.9
import 'package:ecomerce/Services/facebookauth.dart';
import 'package:ecomerce/screens/Category.dart';
import 'package:ecomerce/screens/Splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class On_Bording extends StatelessWidget {
  static String id = 'On_Bording';
  const On_Bording({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height * .9,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Category.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70, left: 300),
                        child: Text('Skip',
                            style: GoogleFonts.montserrat(
                              textStyle:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 90),
                      child: Text('SuperStore',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 80),
                      child: Text('FASHION',
                          style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .35,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 40),
                      child: Text('Welcome',
                          style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(fontSize: 20, color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ]),
              height: MediaQuery.of(context).size.height * .88,
              decoration: new BoxDecoration(
                  color: Color(0xFF040404),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(4, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(23)),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, Splash.id);
                },
                color: Color(0xFFFA4248),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Splash.id);
                      },
                      child: Text('Get Started  ',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.white,
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
