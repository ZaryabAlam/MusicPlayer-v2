import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';
import 'common_outline_button.dart';
import 'common_text.dart';

Future<void> aboutBottomDialog(BuildContext context) async {
  final themeController = Get.find<ThemeController>();
  bool isDarkmode = themeController.isDarkMode.value;
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Material(
            child: Wrap(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/icons/record.png")),
                    const SizedBox(height: 10),
                    CommonText(
                        text: "My Music",
                        weight: FontWeight.w400,
                        fontSize: 22),
                    const SizedBox(height: 10),
                    CommonText(
                        text: "Version 1.0.1",
                        weight: FontWeight.w300,
                        fontSize: 12),
                    CommonText(
                        text: "Build 1", weight: FontWeight.w300, fontSize: 12),
                    const SizedBox(height: 10),
                     CommonText(
                        text: "© Codes Soft all rights reserved", weight: FontWeight.w300, fontSize: 10),
                              const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonOutlineButton(
                            height: 40,
                            width: 100,
                            onPress: () {
                              Get.back();
                            },
                            text: "Okay"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
