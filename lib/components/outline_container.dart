import 'package:flutter/material.dart';

import '../utils/constants.dart';

class OutlineContainer extends StatelessWidget {
  Color? color;
  Color? outlineColor;
  double? radius;
  Widget? child;
  double? padding;
   OutlineContainer({
    super.key,
    this.color,
    this.outlineColor,
    this.radius,
    this.padding,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     padding: EdgeInsets.all(padding ?? 10),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(radius??15),
       color: color?? transparent,
       border: Border.all(color: outlineColor?? white, width: 2)
     ),
     child: child);
  }
}