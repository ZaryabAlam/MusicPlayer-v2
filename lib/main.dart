// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mymusic/app/dashboard/dashboard.dart';
import 'package:mymusic/app/splash/splash_screen.dart';
import 'package:mymusic/components/common_text.dart';
import 'package:mymusic/utils/theme_data.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app/player/controller.dart/audio_player_controller.dart';
import 'app/player/mini_player.dart';
import 'utils/constants.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ThemeController());
  List<Permission> permissions = [Permission.storage];
  await permissions.request();
  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var materialColor = getMaterialColor(primaryAppColor);
  final themeController = Get.find<ThemeController>();
  final AudioPlayerController audioPlayerController =
      Get.put(AudioPlayerController());

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialApp(
          home: Stack(
            children: [
              GetMaterialApp(
                  title: 'Harmonia',
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: themeController.isDarkMode.value
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  defaultTransition: Transition.cupertino,
                  transitionDuration: const Duration(milliseconds: 800),
                  // home: Dashboard(),
                  home: SplashScreen()),
              Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: ((audioPlayerController.isMiniPlayerVisible.value ==
                              true) &&
                          (audioPlayerController.isMainPlayer.value == false))
                      ? AnimatedSwitcher(
                          duration: Duration(milliseconds: 500),
                          child: Dismissible(
                            key: Key("mini"),
                            confirmDismiss: (direction) async {
                              audioPlayerController.audioFiles.value = [];
                              audioPlayerController.currentIndex.value = 0;
                              _audioPlayer.pause();
                              audioPlayerController.dismissMiniPlayer();
                            },
                            child: MiniPlayer(
                                audioPlayer: audioPlayerController.audioPlayer),
                          ))
                      : SizedBox.shrink())
            ],
          ),
        ));
  }
}
