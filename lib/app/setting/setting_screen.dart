import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/common_text.dart';
import '../../components/neu_container.dart';
import '../../controllers/theme_controller.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: CommonText(text: "Setting", fontSize: 22)
     
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              NeuContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CupertinoSwitch(
                      value: themeController.isDarkMode.value,
                      onChanged: (value) {themeController.toggleTheme();},
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
