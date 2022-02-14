// @dart=2.9
import 'package:ecomerce/Provider/ModelHud.dart';
import 'package:ecomerce/Services/auth.dart';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/screens/category.dart';
import 'package:ecomerce/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreatAccount extends StatelessWidget {
  static String id = 'CreatAccount';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email, password;
  final auth = Auth();

  CreatAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: Provider.of<ModelHud>(context).isloading,
            child: Form(
              key: globalKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 15, color: KAppColor),
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    'SuperStore',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const Text(
                    'FASHION',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      validator: (value) {},
                      onTap: () {},
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffDDDDDD)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: KAppColor),
                        ),
                        labelText: "User name",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      onSaved: (value) {
                        email = value;
                      },
                      validator: (value) {},
                      onTap: () {},
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffDDDDDD)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: KAppColor),
                        ),
                        labelText: "Email",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      onSaved: (value) {
                        password = value;
                      },
                      validator: (value) {},
                      onTap: () {},
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffDDDDDD)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: KAppColor),
                        ),
                        labelText: "password",
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 14),

                        // filled: true,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: Builder(builder: (context) {
                      return TextButton(
                        child: const Text(
                          'Creat Account',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          final modelhud =
                              Provider.of<ModelHud>(context, listen: false);
                          modelhud.changeisloading(true);
                          if (globalKey.currentState.validate()) {
                            globalKey.currentState.save();
                            try {
                              await auth.signup(email.trim(), password.trim());
                              modelhud.changeisloading(false);
                              Navigator.pushNamed(context, Category.id);
                            } catch (e) {
                              modelhud.changeisloading(false);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.message),
                              ));
                            }
                          }
                          modelhud.changeisloading(false);
                        },
                        style: TextButton.styleFrom(
                          primary: KAppColor,
                          backgroundColor: KAppColor,
                          shape: const BeveledRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ),
                        // height: 50,
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(color: Color(0xFFFA4248)),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ),
          )),
    );
  }
}
