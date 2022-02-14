// @dart=2.9
import 'dart:ui';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/login.dart';
import 'package:ecomerce/screens/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBord extends StatelessWidget {
  static String id = 'On_Bord';
  const OnBord({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * .8,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 90),
                        child: Text('SuperStore',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                fontSize: 35,
                                color: Colors.white,
                                fontStyle: FontStyle.normal,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text('FASHION',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, top: 40),
                        child: Text('Welcome',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ]),
                height: MediaQuery.of(context).size.height * .8,
                decoration: const BoxDecoration(
                    color: Color(0xFF040404),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(4, 5),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(23),
                        bottomRight: Radius.circular(23))),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Text('Get Started  ',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.white),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  style: TextButton.styleFrom(
                    primary: KAppColor,
                    backgroundColor: KAppColor,
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  // height: 50,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
