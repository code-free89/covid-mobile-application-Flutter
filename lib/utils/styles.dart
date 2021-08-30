import 'package:flutter/material.dart';

class AppStyles {
  static const Color primaryColor = Color(0xFF3A83FF);
  static const Color lightGrayColor = Color(0x70DBDBDB);

  static const defaultText = const TextStyle(
    decoration: TextDecoration.none,
    color: Colors.blue,
    fontWeight: FontWeight.w500,
  );
  static TextStyle grayText10 = defaultText.copyWith(
    color: Colors.black26,
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );
  static TextStyle grayText12 = defaultText.copyWith(
    color: Colors.black26,
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );
  static TextStyle grayText15 = defaultText.copyWith(
    color: Colors.black38,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static TextStyle subTitleText = defaultText.copyWith(
    color: Colors.black87,
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static TextStyle normalText = defaultText.copyWith(
    height: 2,
  );
  static TextStyle titleText = defaultText.copyWith(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20.0,
  );
  static TextStyle descriptionText = defaultText.copyWith(
    height: 2,
    fontWeight: FontWeight.normal,
    fontSize: 15,
    color: Colors.black38,
  );
  static TextStyle disableText = defaultText.copyWith(
    color: Colors.lightBlue,
  );
  static TextStyle greenText = defaultText.copyWith(
    color: Colors.lightGreen,
  );
}
