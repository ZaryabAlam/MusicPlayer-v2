// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryAppColor = Color(0xFF5D75FE);
Color secondaryAppColor = const Color(0xFF6c49e8);

Color darkModeGray = const Color(0xFF716E6E);

Color primaryWhite = Colors.grey.shade300;
Color white = Colors.white;
Color black = Colors.black;
Color red = Colors.red;
Color blue = Colors.blue;
Color green = Colors.green;
Color grey = Colors.grey;
Color orange = Colors.orange;
Color transparent = Colors.transparent;
Color scaffoldBackground = Colors.grey.shade200;

// Size preferredSize =  Size.fromHeight(50.0);

void getBack() {
  Get.back();
}

//------ Converts Color to MaterialColor
MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
