// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mymusic/components/neu_container.dart';

import '../utils/constants.dart';
import 'common_text.dart';

class CommonOutlineButton extends StatelessWidget {
  String text;
  Color? textColor;
  List<Color>? outlineColor;
  Color? containerColor;
  Color? shadowColor;
  double? height;
  double? width;
  final double? borderRadius;
  final Function() onPress;
  CommonOutlineButton({
    super.key,
    required this.text,
    required this.onPress,
    this.containerColor,
    this.outlineColor,
    this.shadowColor,
    this.textColor,
    this.height,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      width: width ?? 200.0,
      padding: EdgeInsets.all(1.2),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: outlineColor ??[
         primaryAppColor,
           secondaryAppColor.withOpacity(0.8),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        // borderRadius: BorderRadius.circular(20.0),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
        // boxShadow: [
        //   BoxShadow(
        //     color:shadowColor?? Colors.grey.shade700,
        //     spreadRadius: 2,
        //     blurRadius: 5,
        //     offset: Offset(0, 3),
        //   ),
        // ],
      ),
      child: NeuContainer(
      radius: 15,
     padding: 0,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 15)),
            onTap: onPress,
            child: Center(
              child: CommonText(
                text: text,
             
                weight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
