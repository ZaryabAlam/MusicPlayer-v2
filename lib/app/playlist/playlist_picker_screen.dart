import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:mymusic/app/playlist/component/song_act_card.dart";

import "../../models/song_model.dart";
import "../../utils/time_format.dart";

class SongPickerScreen extends StatelessWidget {
  final List<SongsModel> audioFiles;
  final Function(List<SongsModel>) onSongsSelected;
  final List<SongsModel> initialSelection; // Existing songs in the playlist

  const SongPickerScreen({
    Key? key,
    required this.audioFiles,
    required this.onSongsSelected,
    this.initialSelection =
        const [], 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SongsModel> selectedSongs = List.from(initialSelection);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Songs"),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              if (selectedSongs.isEmpty) {
                Get.snackbar("Error", "Please select at least one song");
                return;
              }
              onSongsSelected(selectedSongs);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          final audioFile = audioFiles[index];
          return Column(
            children: [
              index == 0
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 0),
              SongActCard(
                  name: audioFile.title,
                  duration: formatDurationMilliseconds(audioFile.duration ?? 0),
                  action: Icon(
                    selectedSongs.contains(audioFile)
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                        
                  ),
                  onPress: () {
                    if (selectedSongs.contains(audioFile)) {
                      selectedSongs.remove(audioFile);
                    } else {
                      selectedSongs.add(audioFile);
                    }
                    (context as Element).markNeedsBuild();
                  }),
              index == audioFiles.length - 1
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 15)
            ],
          );
        },
      ),
    );
  }
}
