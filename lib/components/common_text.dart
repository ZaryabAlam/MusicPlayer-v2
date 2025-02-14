//Common Text Widget

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight weight;
  final double fontSize;
  final TextAlign textAlign;
  final double lineHeight;
  final double letterSpacing;
  final TextOverflow overFlow;
  final FontStyle fontStyle;
  final int? maxLines;
  String? fontFamily;
   CommonText({
    Key? key,
    required this.text,
    this.color,
    this.weight = FontWeight.w300,
    this.fontSize = 14.0,
    this.textAlign = TextAlign.left,
    this.overFlow = TextOverflow.visible,
    this.letterSpacing = 0.10,
    this.lineHeight = 1.2,
    this.fontStyle = FontStyle.normal,
    this.maxLines,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        overflow: overFlow,
        fontFamily: fontFamily ?? "Poppins",
        color: color,
        fontWeight: weight,
        fontSize: fontSize,
        height: lineHeight,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle
      ),
    );
  }
}
