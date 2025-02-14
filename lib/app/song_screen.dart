import "package:flutter/material.dart";
import 'package:on_audio_query/on_audio_query.dart';
import '../utils/permission_handler.dart';
import 'player_screen.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _PlaylistState();
}

class _PlaylistState extends State<SongScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _audioFiles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Songs')),
      body: Column(
        children: [
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _audioFiles.isEmpty
                  ? Center(child: Text('No audio files found'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _audioFiles.length,
                        itemBuilder: (context, index) {
                          final audioFile = _audioFiles[index];
                          return ListTile(
                            leading: QueryArtworkWidget(
                              id: audioFile.id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Icon(Icons.music_note),
                            ),
                            title: Text(audioFile.displayName),
                            subtitle: Text(audioFile.data ?? 'Unknown Artist'),
                            onTap: () {
                              // Play the audio file here
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerScreen(
                                      audioUri: audioFile.uri ?? "",
                                      title: audioFile.title,
                                      artist: audioFile.album,
                                    ),
                                  ));
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

//
//------------------------------ Custom Functions
//
  Future<void> _loadAudioFiles() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files using on_audio_query
        final audioFiles = await _audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.DESC_OR_GREATER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );

        setState(() {
          _audioFiles = audioFiles;
          _isLoading = false;
        });
      } catch (e) {
        print('Failed to fetch audio files: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

//
// ------------------------------ X
//
}
