import 'package:flutter/material.dart';

class AppStyles {
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
  static TextStyle normalText = defaultText.copyWith(
    height: 2,
  );
  static TextStyle titleText = defaultText.copyWith(
    height: 4,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 40.0,
  );
}
