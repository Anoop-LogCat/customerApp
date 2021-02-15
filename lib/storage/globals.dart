library my_prj.globals;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

User user; // get the user for the entire working of app

double height;
double width;
double pixelRatio;
bool large;
bool medium;
bool small;

String shopType; // once the shop type is selected from home screen this will used to search for shops with this category


Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
  return null;
}

