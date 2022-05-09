// https://uigradients.com/#Harvey
// #3f2b96 -> 0xFF3f2b96
// #a8c0ff -> 0xFF3f2b96


import 'package:flutter/cupertino.dart';

class Theme {
  const Theme();

  static const Color gradientStart = Color(0xFF3f2b96);
  static const Color gradientEnd = Color(0xFFa8c0ff);

  static const gradient = LinearGradient(
      colors: [gradientStart, gradientEnd],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0]);
}
