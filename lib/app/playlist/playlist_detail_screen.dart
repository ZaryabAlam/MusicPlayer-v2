import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/song_model.dart';
import '../player_screen.dart';

class PlaylistDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  const PlaylistDetailsScreen({Key? key, required this.playlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songs = List<Map<String, dynamic>>.from(playlist['songs'])
    .map((songMap) => SongsModel.fromJson(songMap))
    .toList();
    return Scaffold(
      appBar: AppBar(title: Text(playlist['name'])),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            title: Text(song.title),
            subtitle: Text(song.album ?? "Unknown Artist"),
            onTap: () {
              Get.to(() => PlayerScreen(
                    audioFiles: songs,
                    currentIndex: index,
                  ));
            },
          );
        },
      ),
    );
  }
}
