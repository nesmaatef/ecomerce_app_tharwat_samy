// @dart=2.9
import 'dart:io';

import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/Services/Store.dart';
import 'package:ecomerce/consts.dart';
import 'package:ecomerce/widgets/custom_text_fields.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Edit_product extends StatefulWidget {
  static String id = 'Edit_product';

  @override
  State<Edit_product> createState() => _Edit_productState();
}

class _Edit_productState extends State<Edit_product> {
  List<String> sexlist = [
    'men',
    'woman',
    'children',
  ];
  List<String> prod_cat = [
    'teshirt',
    'shoes',
  ];
  bool choose = false;
  bool choose1 = false;
  String url;

  final store = Store();

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  String name, price, description, category, image_location, sex;
  File imagefile;

  @override
  Widget build(BuildContext context) {
    products product = ModalRoute.of(context).settings.arguments;
    image_location = product.pimage_location;

    Size size = MediaQuery.of(context).size;
    return Form(
      key: globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
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
                              ? Image.network(product.pimage_location)
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
              hint: product.pname,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextfield(
              onclick: (value) {
                price = value;
              },
              hint: product.pprice,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextfield(
              onclick: (value) {
                description = value;
              },
              hint: product.pdescription,
            ),
            SizedBox(
              height: 20,
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
                  hintText: choose1 ? category : product.pcategory,
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
                  hintText: choose ? sex : product.Psex,
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
            FlatButton(
              color: Color(0xFFFA4248),
              minWidth: 300,
              height: 50,
              onPressed: () {
                image();
                if (globalKey.currentState.validate()) {
                  globalKey.currentState.save();
                  store.EditProduct(
                      ({
                        KProductname: name,
                        KProductprice: price,
                        KProductlocation: image_location,
                        KProductdscription: description,
                        KProductcategory: category
                      }),
                      product.PId);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: Colors.black12)),
              textColor: Colors.white,
              child: Text(
                'Edit product',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  void image() async {
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
  }
}
