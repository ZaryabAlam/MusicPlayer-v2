import "dart:convert";

import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../components/common_text.dart";
import "../../components/gradient_FAB.dart";
import "../song/controller/song_controller.dart";
import "playlist_detail_screen.dart";
import "playlist_picker_screen.dart";

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final SongController songController = Get.put(SongController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CommonText(text: "Playlist", fontSize: 22)),
       body: FutureBuilder<List<dynamic>>(
        future: _getPlaylists(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text("No playlists found"));
          }

          final playlists = snapshot.data!;
          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return ListTile(
                title: Text(playlist['name']),
                onTap: () {
                  Get.to(() => PlaylistDetailsScreen(playlist: playlist));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: GradientOutlineFAB(
          icon: Icons.add,
          onPressed: () {
            _createPlaylistDialog(context);
          }),
    );
  }

//
//
  Future<void> _createPlaylistDialog(BuildContext context) async {
    String playlistName = '';
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Playlist"),
        content: TextField(
          onChanged: (value) {
            playlistName = value;
          },
          decoration: InputDecoration(hintText: "Enter playlist name"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (playlistName.trim().isEmpty) {
                Get.snackbar("Error", "Playlist name cannot be empty");
                return;
              }
              Navigator.pop(context, playlistName);
            },
            child: Text("Create"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    ).then((result) {
      if (result != null) {
        _pickSongsForPlaylist(result as String);
      }
    });
  }

//
//
  Future<void> _pickSongsForPlaylist(String playlistName) async {
    List<dynamic> selectedSongs = [];

    Get.to(() => SongPickerScreen(
          audioFiles: songController.audioFiles,
          onSongsSelected: (songs) {
            _savePlaylist(playlistName, songs);
          },
        ));
  }

//
//

  Future<void> _savePlaylist(String playlistName, List<dynamic> songs) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = prefs.getStringList('playlists') ?? [];

    // Serialize the playlist data
    final playlistData = {
      'name': playlistName,
      'songs': songs.map((song) => song.toJson()).toList(),
    };

    playlists.add(jsonEncode(playlistData));
    await prefs.setStringList('playlists', playlists);

    Get.snackbar("Success", "Playlist '$playlistName' created successfully");
  }

  //
  //
    Future<List<dynamic>> _getPlaylists() async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = prefs.getStringList('playlists') ?? [];
    return playlists.map((json) => jsonDecode(json)).toList();
  }
}
