// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mymusic/app/favorite/favorite_screen.dart";
import "package:mymusic/app/playlist/playlist_screen.dart";
import "package:mymusic/app/setting/setting_screen.dart";

import "../../components/common_text.dart";
import "../../controllers/theme_controller.dart";
import "../../utils/constants.dart";
import "../home/home_screen.dart";

class Dashboard extends StatefulWidget {
  int? index;
  Dashboard({super.key, this.index});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setArgs() {
    setState(() {
      _selectedIndex = widget.index ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    setArgs();
    _pages = [
      HomeScreen(),
      PlaylistScreen(),
      FavoriteScreen(),
      SettingScreen(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        height: 50.0,
        child: CustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    bool darkMode = themeController.isDarkMode.value;
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: themeController.isDarkMode.value
              ? Colors.grey.shade900
              : Colors.grey.shade200,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(
                icon: selectedIndex == 0
                    ? "assets/icons/home_solid.png"
                    : "assets/icons/home.png",
                color: selectedIndex == 0
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.grey.shade300
                    : transparent,
                iconColor: selectedIndex == 0
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade400
                        : Colors.black87
                    : Colors.grey.shade400,
                label: 'Home'.tr,
                index: 0,
              ),
              _buildNavItem(
                icon: selectedIndex == 1
                    ? "assets/icons/playlist_solid.png"
                    : "assets/icons/playlist.png",
                color: selectedIndex == 1
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.grey.shade300
                    : transparent,
                iconColor: selectedIndex == 1
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade400
                        : Colors.black87
                    : Colors.grey.shade400,
                label: 'Playlist'.tr,
                index: 1,
              ),
              _buildNavItem(
                icon: selectedIndex == 2
                    ? "assets/icons/fav_solid.png"
                    : "assets/icons/fav.png",
                color: selectedIndex == 2
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.grey.shade300
                    : transparent,
                iconColor: selectedIndex == 2
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade400
                        : Colors.black87
                    : Colors.grey.shade400,
                label: 'Favorite'.tr,
                index: 2,
              ),
              _buildNavItem(
                icon: selectedIndex == 3
                    ? "assets/icons/settings_solid.png"
                    : "assets/icons/settings.png",
                color: selectedIndex == 3
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade800
                        : Colors.grey.shade300
                    : transparent,
                iconColor: selectedIndex == 3
                    ? themeController.isDarkMode.value
                        ? Colors.grey.shade400
                        : Colors.black87
                    : Colors.grey.shade400,
                label: 'Settings'.tr,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String icon,
    required String label,
    required int index,
    required Color? color,
    required Color? iconColor,
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Image(
                  height: 22,
                  width: 22,
                  image: AssetImage("$icon"),
                  fit: BoxFit.contain,
                  color: iconColor,
                )),
          ),
          // Icon(icon, color: index == selectedIndex ? Colors.black : Colors.white54),
          CommonText(
            text: label,
            color: iconColor,
            fontSize: 8,
            weight: index == selectedIndex ? FontWeight.w600 : FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
