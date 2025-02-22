import"package:flutter/material.dart";
import "package:get/get.dart";

import "../../models/song_model.dart";

class SongPickerScreen extends StatelessWidget {
  final List<SongsModel> audioFiles;
  final Function(List<SongsModel>) onSongsSelected;
  final List<SongsModel> initialSelection; // Existing songs in the playlist

  const SongPickerScreen({
    Key? key,
    required this.audioFiles,
    required this.onSongsSelected,
    this.initialSelection = const [], // Default to an empty list if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize selectedSongs with the initial selection
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
              // Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          final audioFile = audioFiles[index];
          return ListTile(
            title: Text(audioFile.title),
            subtitle: Text(audioFile.album ?? "Unknown Album"),
            trailing: Icon(
              selectedSongs.contains(audioFile)
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
            onTap: () {
              if (selectedSongs.contains(audioFile)) {
                selectedSongs.remove(audioFile);
              } else {
                selectedSongs.add(audioFile);
              }
              (context as Element).markNeedsBuild();
            },
          );
        },
      ),
    );
  }
}