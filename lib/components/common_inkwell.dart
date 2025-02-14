// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

class CommonInkwell extends StatelessWidget {
  Widget child;
  final Function() onPress;
  double? space;
  double? radius;
  CommonInkwell({
    required this.child,
    required this.onPress,
    this.space,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius ?? 15.0),
        onTap: onPress,
        child: Container(margin: EdgeInsets.all(space ?? 10), child: child),
      ),
    );
  }
}
