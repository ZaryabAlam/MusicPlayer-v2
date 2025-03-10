import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../components/empty_card_small.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player/controller.dart/audio_player_controller.dart';
import '../player/player_screen.dart';

class AlbumSongScreen extends StatelessWidget {
  final String folderName;
  final List<SongModel> folderFiles;

  AlbumSongScreen({
    Key? key,
    required this.folderName,
    required this.folderFiles,
  }) : super(key: key);

  final audioPlayerController = Get.find<AudioPlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(folderName),
      ),
      body: Column(
        children: [
          folderFiles.isEmpty
              ? EmptyCardSmall()
              : Expanded(
                  child: ListView.builder(
                    itemCount: folderFiles.length,
                    itemBuilder: (context, index) {
                      final audioFile = folderFiles[index];
                      return Column(
                        children: [
                          index == 0
                              ? const SizedBox(height: 20)
                              : const SizedBox(height: 0),
                          SongListItem(
                            name: audioFile.title,
                            duration: formatDurationMilliseconds(
                                audioFile.duration ?? 0),
                            onPress: () {
                              audioPlayerController.audioFiles
                                  .assignAll(folderFiles);
                              audioPlayerController.currentIndex.value = index;
                              Get.to(() => PlayerScreen(
                                    reset: true,
                                    audioFiles: folderFiles,
                                    currentIndex: index,
                                  ));
                            },
                          ),
                          index == folderFiles.length - 1
                              ? const SizedBox(height: 20)
                              : const SizedBox(height: 15)
                        ],
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
