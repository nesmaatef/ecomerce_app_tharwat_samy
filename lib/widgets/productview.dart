import 'package:ecomerce/Models/Products.dart';
import 'package:ecomerce/functions.dart';
import 'package:flutter/material.dart';

Widget productview(String pcategory, List<products> allproduct) {
  List<products> product;
  product = getproductbycategory(pcategory, allproduct);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: .8),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * .8,
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  height: MediaQuery.of(context).size.height * .23,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(product[index].pimage_location),
                  fit: BoxFit.fill,
                ),
              ),
              Opacity(
                opacity: .6,
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product[index].pname,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('\$ ${product[index].pprice}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.red)),
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  height: 60,
                ),
              ),
            ],
          ),
        ),
      ),
      itemCount: product.length,
    ),
  );
}
