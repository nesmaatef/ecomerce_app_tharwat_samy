// @dart=2.9
import 'dart:ui';

import 'package:ecomerce/Provider/AdminMode.dart';
import 'package:ecomerce/Provider/ModelHud.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecomerce/Services/auth.dart';
import 'package:ecomerce/Services/facebookauth.dart';
import 'package:ecomerce/screens/Admin/AdminHome.dart';
import 'package:ecomerce/screens/Category.dart';
import 'package:ecomerce/screens/CreatAccount.dart';
import 'package:ecomerce/screens/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  static String id = 'Splash';
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final String adminpassword = '123456789';
  String email, password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      body: Form(
        key: globalKey,
        child: ListView(children: [
          Container(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF3d1308),
                  //  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 100),
                    child: Text(
                      'Superstore',
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 180),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .4,
                    decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(4, 5),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Welcome',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Signip to get started',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            onSaved: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFFA4248)),
                              ),
                              labelText: "username",
                              labelStyle: new TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            onSaved: (value) {
                              password = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),

                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFFA4248)),
                              ),
                              labelText: "password",
                              labelStyle: new TextStyle(
                                  color: Colors.black, fontSize: 16),

                              // filled: true,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Builder(builder: (context) {
                          return FlatButton(
                            onPressed: () {
                              validate(context);
                            },
                            color: Color(0xFFf01738),
                            minWidth: 300,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          );
                        }),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text('Or',
                  style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ))),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Do not have an account',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Creat_Account.id);
                },
                child: Text(
                  'Sign up',
                  style: GoogleFonts.montserrat(
                      textStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Color(0xFFFA4248),
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              signInWithFacebook();
              Navigator.pushNamed(context, Category.id);
            },
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  onPressed: () {
                    signInWithFacebook();
                    Navigator.pushNamed(context, Category.id);
                  },
                  color: Colors.blue,
                  minWidth: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/vector.png'),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Sign in with Facebook',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(color: Colors.black12)),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FlatButton(
                onPressed: () {
                  signInWithGoogle();
                  Navigator.pushNamed(context, Category.id);
                },
                color: Color(0xFFFA4248),
                minWidth: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('lib/images/vector1.png'),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Sign in with Google',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(color: Colors.black12)),
              )),
        ]),
      ),
    );
  }

  void validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisloading(true);
    if (globalKey.currentState.validate()) {
      globalKey.currentState.save();

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
      }
      // else {
      // modelhud.changeisloading(false);
      // Scaffold.of(context).showSnackBar(SnackBar(
      //  content: Text('something is wrong'),
      //));
      //}
      //}
      else {
        try {
          await auth.signin(email.trim(), password.trim());
          modelhud.changeisloading(false);
          Navigator.pushNamed(context, Category.id);
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

signInWithFacebook() async {
  final fb = FacebookLogin();
  // Log in
  final res = await fb.logIn(permissions: [
    FacebookPermission.publicProfile,
    FacebookPermission.email,
  ]);
  // Check result status
  switch (res.status) {
    case FacebookLoginStatus.success:
      // The user is suceessfully logged in
      // Send access token to server for validation and auth
      final FacebookAccessToken accessToken = res.accessToken;
      final AuthCredential authCredential =
          FacebookAuthProvider.credential(accessToken.token);
      final result =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      // Get profile data from facebook for use in the app
      final profile = await fb.getUserProfile();
      print('Hello, ${profile.name}! You ID: ${profile.userId}');
      // Get user profile image url
      final imageUrl = await fb.getProfileImageUrl(width: 100);
      print('Your profile image: $imageUrl');
      // fetch user email
      final email = await fb.getUserEmail();
      // But user can decline permission
      if (email != null) print('And your email is $email');
      break;
    case FacebookLoginStatus.cancel:
      // In case the user cancels the login process
      break;
    case FacebookLoginStatus.error:
      // Login procedure failed
      print('Error while log in: ${res.error}');
      break;
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Initiate the auth procedure
  final GoogleSignInAccount googleUser =
      await GoogleSignIn(scopes: <String>["email"]).signIn();
  // fetch the auth details from the request made earlier
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  // Create a new credential for signing in with google
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
