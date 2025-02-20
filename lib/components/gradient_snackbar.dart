import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar gradientSnackbar(tText, sText, sColor, sIcon) {
  return GetSnackBar(
    barBlur: 3.0,
    title: tText,
    message: (sText),
    borderColor: sColor,
    borderWidth: 1,
    snackStyle: SnackStyle.FLOATING,
    dismissDirection: DismissDirection.vertical,
    margin: EdgeInsets.all(10),
    backgroundGradient:
        LinearGradient(colors: [sColor, sColor.withOpacity(0.5)]),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    icon: Icon(sIcon, color: Colors.white, size: 32),

    borderRadius: 10,
    duration: Duration(seconds: 3),
    // backgroundColor: sColor,
  );
}
