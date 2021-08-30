import 'package:flutter/material.dart';
import 'package:flutter_app/constants/UIConstants/color_pallet.dart';

class TextStyles {
  static TextStyle topBarTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFF999999),
  );

  static TextStyle search = TextStyle(
  fontFamily: 'Roboto',
  fontSize: 20
  );

  static TextStyle main = TextStyle(
      fontSize: 22,
      fontFamily: 'Roboto');

  static TextStyle textStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,);

  static TextStyle temperatureStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      fontWeight: FontWeight.bold);

  static TextStyle descriptionStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 14,);

  static TextStyle cityStyle = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 34,
    fontWeight: FontWeight.bold,);

  static TextStyle iosStyle = TextStyle(
    fontSize: 40,
    fontFamily: 'Qwigley',
    color: Colors.white,
  );

  static TextStyle splashStyle = TextStyle(
    fontSize: 90,
    fontFamily: 'Qwigley',
    color: Colors.white,
  );
}