import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
              ? Center(child: Text('No audio files found in $folderName'))
              : Expanded(
                  child: ListView.builder(
                    itemCount: folderFiles.length,
                    itemBuilder: (context, index) {
                      final audioFile = folderFiles[index];
                      return ListTile(
                        leading: QueryArtworkWidget(
                          id: audioFile.id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(Icons.music_note),
                        ),
                        title: Text(audioFile.title),
                        subtitle: Text(audioFile.artist ?? 'Unknown Artist'),
                        onTap: () {
                          // Play the audio file here
                          print('Playing: ${audioFile.uri}');
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
