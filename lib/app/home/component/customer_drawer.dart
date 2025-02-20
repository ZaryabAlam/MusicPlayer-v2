import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic/app/favorite/favorite_screen.dart';
import 'package:mymusic/app/setting/setting_screen.dart';

import '../../playlist/playlist_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
              child: Center(
            child: Image(
                                    height: 300,
                                    width: 300,
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/icons/record.png"))
          )),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home_rounded),
              onTap: () {
                Get.back();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: ListTile(
              title: Text("Playlist"),
              leading: Icon(Icons.stars_rounded),
              onTap: () {
             Get.back();
             Get.to(()=>PlaylistScreen());
              },
            ),
          ),
           Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: ListTile(
              title: Text("Favorite"),
              leading: Icon(Icons.favorite_rounded),
              onTap: () {
             Get.back();
             Get.to(()=>FavoriteScreen());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, left: 25),
            child: ListTile(
              title: Text("Settings"),
              leading: Icon(Icons.settings_rounded),
              onTap: () {
             Get.back();
             Get.to(()=>SettingScreen());
              },
            ),
          )
        ],
      ),
    );
  }
}
