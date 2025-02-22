import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'common_text.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final Color? color;
  final Color? shadowColor;
  final Function() onPress;
  final double? borderRadius;
  CommonButton(
      {super.key,
      required this.text,
      required this.onPress,
      this.borderRadius,
      this.color,
      this.shadowColor,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color ?? primaryAppColor,
            color?.withOpacity(0.8) ?? secondaryAppColor.withOpacity(0.8),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        // borderRadius: BorderRadius.circular(20.0),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // borderRadius: BorderRadius.circular(40.0),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
          onTap: onPress,
          child: Center(
            child: CommonText(
              textAlign: TextAlign.center,
              text: " $text ",
             
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
