import"package:flutter/material.dart";
import "package:get/get.dart";

class SongPickerScreen extends StatelessWidget {
  final List<dynamic> audioFiles;
  final Function(List<dynamic>) onSongsSelected;

  const SongPickerScreen({
    Key? key,
    required this.audioFiles,
    required this.onSongsSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> selectedSongs = [];

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
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: audioFiles.length,
        itemBuilder: (context, index) {
          final audioFile = audioFiles[index];
          return ListTile(
            // leading: QueryArtworkWidget(
            //   id: audioFile.id,
            //   type: ArtworkType.AUDIO,
            //   nullArtworkWidget: Icon(Icons.music_note),
            // ),
            title: Text(audioFile.title),
            subtitle: Text(audioFile.artist ?? "Unknown Artist"),
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
              // Trigger UI update
              (context as Element).markNeedsBuild();
            },
          );
        },
      ),
    );
  }
}