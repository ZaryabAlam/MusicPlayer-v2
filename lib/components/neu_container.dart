// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class NeuContainer extends StatelessWidget {
  double? padding;
  double? radius;
  final Widget? child;
  NeuContainer({super.key, required this.child, this.padding, this.radius});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    bool isDarkmode = themeController.isDarkMode.value;
    
    return Container(
      padding: EdgeInsets.all(padding ?? 10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(radius?? 15),
          boxShadow: [
            BoxShadow(
                color: isDarkmode ? Colors.black : Colors.grey.shade400,
                blurRadius: 15,
                offset: Offset(4, 4)),
            BoxShadow(
                color: isDarkmode ? Colors.grey.shade800 : Colors.white,
                blurRadius: 13,
                offset: Offset(-4, -4))
          ]),
      child: child,
    );
  }
}
