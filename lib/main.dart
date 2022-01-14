// @dart=2.9
import 'package:ecomerce/Provider/AdminMode.dart';
import 'package:ecomerce/Provider/Favorite.dart';
import 'package:ecomerce/Provider/ModelHud.dart';
import 'package:ecomerce/Services/facebookauth.dart';
import 'package:ecomerce/screens/Admin/AddProduct.dart';
import 'package:ecomerce/screens/Admin/AdminHome.dart';
import 'package:ecomerce/screens/Admin/Editproductscreen.dart';
import 'package:ecomerce/screens/Admin/updateproduct.dart';
import 'package:ecomerce/Provider/CartItem.dart';
import 'package:ecomerce/screens/CartScreen.dart';
import 'package:ecomerce/screens/Category.dart';
import 'package:ecomerce/screens/CreatAccount.dart';
import 'package:ecomerce/screens/FavoriteScreen.dart';
import 'package:ecomerce/screens/Home.dart';
import 'package:ecomerce/screens/OnBording.dart';
import 'package:ecomerce/screens/ProductInfo.dart';
import 'package:ecomerce/screens/Splash.dart';
import 'package:ecomerce/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<FavoriteItem>(
          create: (context) => FavoriteItem(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        )
      ],
      child: MaterialApp(
        //  home: AuthService().handleAuthState(),
        initialRoute: Category.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          Cart.id: (context) => Cart(),
          Info.id: (context) => Info(),
          AdminHome.id: (context) => AdminHome(),
          Home.id: (context) => Home(),
          AddProduct.id: (context) => AddProduct(),
          Update_Product.id: (context) => Update_Product(),
          Edit_product.id: (context) => Edit_product(),
          Splash.id: (context) => Splash(),
          On_Bording.id: (context) => On_Bording(),
          Creat_Account.id: (context) => Creat_Account(),
          Category.id: (context) => Category(),
          FavoriteScreen.id: (context) => FavoriteScreen(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
