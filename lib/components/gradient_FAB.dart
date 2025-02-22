import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic/components/common_inkwell.dart';
import 'dart:math' as math;

import '../controllers/theme_controller.dart';
import '../utils/constants.dart';
import 'neu_container.dart';

class GradientOutlineFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  GradientOutlineFAB({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    bool isDarkmode = themeController.isDarkMode.value;

    return Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: <Color>[primaryAppColor, secondaryAppColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 5,
              offset:  Offset(2, 2),
            ),
          ],
        ),
        child: NeuContainer(
          padding: 0,
          radius: 14,
          child: CommonInkwell(
              onPress: onPressed,
              space: 0,
              radius: 14,
              child:   Icon(
              icon,
                color: isDarkmode ?  primaryWhite : Colors.black87,
              )),
        ));
  }
}
