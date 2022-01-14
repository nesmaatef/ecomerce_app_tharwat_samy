// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Services/Store.dart';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/widgets/custom_text_fields.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  //const AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String url;
  bool choose = false;
  bool choose1 = false;
  File imagefile;
  List<String> sexlist = [
    'men',
    'women',
    'children',
  ];
  List<String> prod_cat = [
    'teshirt',
    'shoes',
  ];
  final store = Store();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String name, price, description, category, image_location, sex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                width: size.width * 0.24,
                height: size.width * 0.24,
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 160),
                    child: Container(
                        width: size.width * 0.24,
                        height: size.width * 0.24,
                        // color: Colors.deepOrange,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            getimagefromgallary();
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: imagefile == null
                                ? Icon(Icons.add_a_photo)
                                : Image.file(
                                    imagefile,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        )),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextfield(
                onclick: (value) {
                  name = value;
                },
                hint: 'Product name',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                onclick: (value) {
                  price = value;
                },
                hint: 'Product price',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextfield(
                onclick: (value) {
                  description = value;
                },
                hint: 'Product description',
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.name,
                  onTap: () {
                    showcategorydialog(size: size);
                  },
                  validator: (value) {
                    if (category.isEmpty) {
                      return ("enter category please");
                    }
                    return null;
                  },
                  cursorColor: KMainColor,
                  decoration: InputDecoration(
                    hintText: choose1 ? category : 'product category ',
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.name,
                  onTap: () {
                    showsexdialog(size: size);
                  },
                  validator: (value) {
                    if (sex.isEmpty) {
                      return ("enter sex please");
                    }
                    return null;
                  },
                  cursorColor: KMainColor,
                  decoration: InputDecoration(
                    hintText: choose ? sex : 'product sex ',
                    hintStyle: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FlatButton(
                    onPressed: () {
                      addproductpage();
                    },
                    color: Color(0xFFFA4248),
                    minWidth: 300,
                    height: 50,
                    child: Text(
                      'Add Product',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: Colors.black12)),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void addproductpage() async {
    if (globalKey.currentState.validate()) {
      if (imagefile != null) {
        var timekey = new DateTime.now();
        final ref = FirebaseStorage.instance
            .ref()
            .child('productimage')
            .child(timekey.toString() + '.jpg');

        await ref.putFile(imagefile);
        var imageurl = await ref.getDownloadURL();
        url = imageurl.toString();
        image_location = url;
      }

      globalKey.currentState.save();

      store.addproduct(products(
          pname: name,
          pdescription: description,
          pcategory: category,
          pprice: price,
          pimage_location: image_location,
          Psex: sex));
    }
    choose = false;
    choose1 = false;
  }

  showsexdialog({Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Chosse',
              style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: sexlist.length,
                  itemBuilder: (ctxx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          sex = sexlist[index];
                          choose = true;
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.redAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              sexlist[index],
                              style: TextStyle(
                                  fontSize: 16.0, fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }

  void getimagefromgallary() async {
    PickedFile pickedfile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    //cropImage(pickedfile.path);
    setState(() {
      imagefile = File(pickedfile.path);
    });
    // Navigator.pop(context);
  }

  void cropImage(filepath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filepath, maxWidth: 1080, maxHeight: 1080);
    if (croppedImage != null) {
      setState(() {
        imagefile = croppedImage;
      });
    }
  }

  void showcategorydialog({Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Chosse',
              style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: prod_cat.length,
                  itemBuilder: (ctxx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          category = prod_cat[index];
                          choose1 = true;
                        });
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: Colors.redAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              prod_cat[index],
                              style: TextStyle(
                                  fontSize: 16.0, fontStyle: FontStyle.italic),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text('Close'),
              ),
            ],
          );
        });
  }
}
