import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../components/empty_card_small.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player_screen.dart';

class AlbumSongScreen extends StatelessWidget {
  final String folderName;
  final List<SongModel> folderFiles;

  const AlbumSongScreen({
    Key? key,
    required this.folderName,
    required this.folderFiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Album Song"),
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
                            children: [  index ==  0
                                            ? const SizedBox(height: 20)
                                            : const SizedBox(height: 0),
                              SongListItem(
                                name: audioFile.title,
                                duration: formatDurationMilliseconds(
                                    audioFile.duration ?? 0),
                                onPress: () {
                                  Get.to(() => PlayerScreen(
                                      audioUri: audioFile.uri ?? "",
                                      title: audioFile.title,
                                      artist: audioFile.album));
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
