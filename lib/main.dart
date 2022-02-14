// @dart=2.9
import 'package:ecomerce/Provider/AdminMode.dart';
import 'package:ecomerce/Provider/Favorite.dart';
import 'package:ecomerce/Provider/ModelHud.dart';
import 'package:ecomerce/screens/Admin/AddProduct.dart';
import 'package:ecomerce/screens/Admin/AdminHome.dart';
import 'package:ecomerce/screens/Admin/Editproductscreen.dart';
import 'package:ecomerce/screens/Admin/updateproduct.dart';
import 'package:ecomerce/Provider/CartItem.dart';
import 'package:ecomerce/screens/cart_screen.dart';
import 'package:ecomerce/screens/category.dart';
import 'package:ecomerce/screens/main_home.dart';
import 'package:ecomerce/screens/make_new_account.dart';
import 'package:ecomerce/screens/FavoriteScreen.dart';
import 'package:ecomerce/screens/home.dart';
import 'package:ecomerce/screens/home_page.dart';
import 'package:ecomerce/screens/on_bording.dart';
import 'package:ecomerce/screens/product_info.dart';
import 'package:ecomerce/screens/SearchScreen.dart';
import 'package:ecomerce/screens/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

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
        initialRoute: HomePage.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          MainHome.id: (context) => const MainHome(),
          Cart.id: (context) => Cart(),
          Info.id: (context) => Info(),
          AdminHome.id: (context) => AdminHome(),
          Home.id: (context) => Home(),
          AddProduct.id: (context) => AddProduct(),
          UpdateProduct.id: (context) => const UpdateProduct(),
          Edit_product.id: (context) => Edit_product(),
          LoginScreen.id: (context) => LoginScreen(),
          OnBord.id: (context) => const OnBord(),
          CreatAccount.id: (context) => CreatAccount(),
          Category.id: (context) => Category(),
          FavoriteScreen.id: (context) => FavoriteScreen(),
          SearchScreen.id: (context) => SearchScreen(),
          HomePage.id: (context) => const HomePage(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
