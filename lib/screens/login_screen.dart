// @dart=2.9
import 'dart:ui';

import 'package:ecomerce/Provider/AdminMode.dart';
import 'package:ecomerce/Provider/ModelHud.dart';
import 'package:ecomerce/Services/auth.dart';
import 'package:ecomerce/consts.dart';
import 'Admin/AdminHome.dart';
import 'package:ecomerce/screens/Home.dart';
import 'package:ecomerce/widgets/custom_text_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final String adminpassword = 'admin1234';
  String email, password;
  final auth = Auth();
  // final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KMainColor,
      body: Form(
        key: globalKey,
        child: ListView(
          children: [
            SizedBox(height: 60),
            Container(
              height: MediaQuery.of(context).size.height * .2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: AssetImage('lib/images/icon1.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      'BuyIt',
                      style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            CustomTextfield(
                onclick: (value) {
                  email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email),
            SizedBox(height: height * .02),
            CustomTextfield(
                onclick: (value) {
                  password = value;
                },
                hint: 'Enter your Password',
                icon: Icons.lock),
            SizedBox(height: height * .02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110),
              child: Builder(
                builder: (context) => FlatButton(
                  onPressed: () {
                    validate(context);
                  },
                  color: Colors.black,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            SizedBox(height: height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustemText(
                  text: 'Do not have account ?',
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {},
                  child: CustemText(
                    text: 'Sign up',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeisadmin(true);
                    },
                    child: Text(
                      'i am admin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? KMainColor
                              : Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<AdminMode>(context, listen: false)
                          .changeisadmin(false);
                    },
                    child: Text(
                      'i am user',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.white
                              : KMainColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisloading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminpassword) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('true')));
          try {
            await auth.signin(email.trim(), password.trim());
            modelhud.changeisloading(false);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelhud.changeisloading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modelhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('something is wrong'),
          ));
        }
      } else {
        try {
          await auth.signin(email.trim(), password.trim());
          modelhud.changeisloading(false);
          Navigator.pushNamed(context, Home.id);
        } catch (e) {
          modelhud.changeisloading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeisloading(false);
  }
}
