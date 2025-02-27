import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";

import "../app/player/mini_player.dart";
import "../utils/constants.dart";

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget appBar;
  final Widget? drawer;
  final AudioPlayer audioPlayer;

  const CustomScaffold({
    Key? key,
    required this.body,
    required this.appBar,
    required this.audioPlayer,
    this.drawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return drawer == null
        ? Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), child: appBar),
            body: Stack(
              children: [
                body,
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // child: MiniPlayer(audioPlayer: audioPlayer),
                  child: Container(
                      margin: EdgeInsets.all(20),
                    height: 40,
                    color: red,
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.0), child: appBar),
            drawer: drawer,
            body: Stack(
              children: [
                body,
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // child: MiniPlayer(audioPlayer: audioPlayer),
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 40,
                    color: red,
                  ),
                ),
              ],
            ),
          );
  }
}
