// @dart=2.9
import 'package:ecomerce/Provider/ModelHud.dart';
import 'package:ecomerce/Services/auth.dart';
import 'package:ecomerce/screens/Category.dart';
import 'package:ecomerce/screens/Splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class Creat_Account extends StatelessWidget {
  static String id = 'Creat_Account';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email, password;
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
        backgroundColor: Color(0xFFFBFBFB),
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isloading,
          child: Form(
            key: globalKey,
            child: ListView(children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 15, color: Color(0xFFFA4248)),
                  ),
                  SizedBox(width: 15),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'SuperStore',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: Colors.black),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                'FASHION',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  validator: (value) {},
                  onTap: () {},
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFA4248)),
                    ),
                    labelText: "name",
                    labelStyle:
                        new TextStyle(color: Colors.black26, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
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
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFA4248)),
                    ),
                    labelText: "user name",
                    labelStyle:
                        new TextStyle(color: Colors.black26, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
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
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFA4248)),
                    ),
                    labelText: "password",
                    labelStyle:
                        new TextStyle(color: Colors.black26, fontSize: 16),

                    // filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Builder(builder: (context) {
                return FlatButton(
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
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(e.message),
                        ));
                      }
                    }
                    modelhud.changeisloading(false);
                  },
                  height: 50,
                  minWidth: 300,
                  color: Color(0xFFf01738),
                  child: Text(
                    'Creat Account',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Splash.id);
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Splash.id);
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Color(0xFFFA4248)),
                      ),
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}
