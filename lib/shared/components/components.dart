

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const  Color yellow = Color(0xFFFFBF00);
const Color more2grey =Color(0xFFA39F9F);
const Color moregrey=Color(0xFFB3B3B3);

Widget defultButton ({
  double width = double.infinity,
 // double heigght,
  required String text,
  required Function function,
  Color borderColor = yellow,
  Color backgroundColor = yellow,
  Color textColor = Colors.white,
})
 =>Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    border:Border.all(color: borderColor),
    color: backgroundColor
  ),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: MaterialButton(
    onPressed: () => function(), // أو onPressed: function,
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
      ),
    ),
  ),
);

Widget defaultFormField({

  required TextEditingController controller,
  required TextInputType type,
   onSubmit,
   onChange,
  bool isPassword=false,
  required String? Function(String?) validate,
  required String hint,
  prefix,
  Color,
  suffix,
}) => Directionality(
  textDirection: TextDirection.ltr,
  child: TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    textAlign: TextAlign.start,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: moregrey,
        fontSize: 14,
      ),
      prefixIcon: prefix != null ? Icon(prefix, color: moregrey) : null,
      suffixIcon: suffix != null ? Icon(suffix, color: moregrey) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: yellow),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: yellow),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(color: yellow),
      ),
    ),
  ),
);



