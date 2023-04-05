import 'package:flutter/material.dart';

const primary = Color(0xff4f359b);
const white = Color(0xffffffff);
hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}