// @dart=2.9
import 'package:ecomerce/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextfield extends StatelessWidget {
  String hint;
  IconData icon;
  final Function onclick;

  String errormessage(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'name is empty ';
      case 'Enter your email':
        return 'email is empty ';
      case 'Enter your Password':
        return 'password is empty ';
    }
  }

  CustomTextfield({this.onclick, this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return errormessage(hint);
          }
          return null;
        },
        onSaved: onclick,
        obscureText: hint == 'Enter your Password' ? true : false,
        cursorColor: Colors.black12,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          prefixIcon: Icon(icon),
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
    );
  }
}

class CustemText extends StatelessWidget {
  String text;
  Color color;

  CustemText({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: 16),
    );
  }
}
