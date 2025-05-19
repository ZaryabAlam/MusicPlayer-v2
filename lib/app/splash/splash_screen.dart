import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
import "package:get/get.dart";
import "package:mymusic/app/dashboard/dashboard.dart";

import "../../controllers/theme_controller.dart";
import "../../utils/constants.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
    navigator();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = themeController.isDarkMode.value;
    return SafeArea(
      child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (didPop) {
              return;
            }
          },
          child: Scaffold(
              body: Center(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: darkMode
                          ? [
                              Colors.grey.shade900,
                              Colors.grey.shade900,
                              Colors.grey.shade900,
                              primaryAppColor.withOpacity(0.6),
                            ]
                          : [
                              Colors.grey.shade200,
                              Colors.grey.shade200,
                              Colors.grey.shade200,
                              grey.withOpacity(0.6),
                            ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Hero(
                        tag: "appLogo",
                        child: Image(
                                height: 100,
                                width: 100,
                                image: AssetImage(
                                    "assets/logos/app_logo_full.png"),
                                fit: BoxFit.contain)
                            .animate()
                            .fadeIn(delay: 150.ms, duration: 700.ms),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))),
    );
  }

//--------------- Custom Functions
//

//------------- To Route to screens
  void navigator() {
    Future.delayed(Duration(seconds: 1), () {
      Get.offAll(() => Dashboard());
    });
  }
}
