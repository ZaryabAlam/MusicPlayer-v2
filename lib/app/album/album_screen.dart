import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart' as path;

import '../../utils/permission_handler.dart';
import 'album_song_screen.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumState();
}

class _AlbumState extends State<AlbumScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Map<String, List<SongModel>> _audioFolders = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAudioFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Albums")),
      body: Column(
        children: [
        _isLoading
          ? Center(child: CircularProgressIndicator())
          : _audioFolders.isEmpty
              ? Center(child: Text('No audio folders found'))
              : Expanded(
                child: ListView.builder(
                    itemCount: _audioFolders.length,
                    itemBuilder: (context, index) {
                      String folderName = _audioFolders.keys.elementAt(index);
                      List<SongModel> folderFiles = _audioFolders[folderName]!;
                      return ListTile(
                        title: Text(folderName),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AlbumSongScreen(
                                folderName: folderName,
                                folderFiles: folderFiles,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
              ),],
      ),
    );
  }

//
// ------------------------------ Custom Functions
//

// ------------------------------ Fetch Audio Folders 

  Future<void> _loadAudioFolders() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files
        final audioFiles = await _audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );
        Map<String, List<SongModel>> folders = {};
        for (var audioFile in audioFiles) {
          String folderPath = path.dirname(audioFile.data); // Extract folder path
          String folderName = path.basename(folderPath); // Extract folder name

          if (!folders.containsKey(folderName)) {
            folders[folderName] = [];
          }
          folders[folderName]!.add(audioFile);
        }

        setState(() {
          _audioFolders = folders;
          _isLoading = false;
        });
      } catch (e) {
        print('Failed to fetch audio folders: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

}
