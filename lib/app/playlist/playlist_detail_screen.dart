import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic/utils/constants.dart';

import '../../components/gradient_FAB.dart';
import '../../models/song_model.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player/player_screen.dart';
import '../song/controller/song_controller.dart';
import 'controller/playlist_controller.dart';


class PlaylistDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  const PlaylistDetailsScreen({Key? key, required this.playlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SongController songController = Get.put(SongController());
    final PlaylistController playlistController = Get.put(PlaylistController());

    final songs = List<Map<String, dynamic>>.from(playlist['songs'])
        .map((songMap) => SongsModel.fromJson(songMap))
        .toList();

    return Scaffold(
      appBar: AppBar(
          title: Text(playlist['name'].toString().capitalizeFirst ?? ""),
          actions: [
            IconButton(
              icon: Icon(Icons.delete, color: grey),
              onPressed: () async {
                Get.back();
                await playlistController.deletePlaylist(
                    context, playlist['name']);
              },
            ),
          ]),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Column(
            children: [
              index == 0
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 0),
              SongListItem(
                  name: song.title,
                  duration: formatDurationMilliseconds(song.duration ?? 0),
                  onPress: () {
                    Get.to(() =>
                        PlayerScreen(audioFiles: songs, currentIndex: index));
                  }),
              index == songs.length - 1
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 15)
            ],
          );
        },
      ),
      floatingActionButton: GradientOutlineFAB(
          icon: Icons.edit_note_rounded,
          onPressed: () {
           playlistController.editPlaylist(context, playlist['name'], songs, songController);
          }),
    );
  }
}
