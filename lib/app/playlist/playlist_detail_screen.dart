import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/gradient_FAB.dart';
import '../../models/song_model.dart';
import '../player_screen.dart';
import '../song/controller/song_controller.dart';
import 'playlist_picker_screen.dart';

class PlaylistDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  const PlaylistDetailsScreen({Key? key, required this.playlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SongController songController = Get.put(SongController());

    final songs = List<Map<String, dynamic>>.from(playlist['songs'])
        .map((songMap) => SongsModel.fromJson(songMap))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(playlist['name']),
      actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _deletePlaylist(context, playlist['name']);
            },
          ),
        ]),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            title: Text(song.title),
            subtitle: Text(song.album),
            onTap: () {
              Get.to(() => PlayerScreen(
                    audioFiles: songs,
                    currentIndex: index,
                  ));
            },
          );
        },
      ),
      floatingActionButton: GradientOutlineFAB(
          icon: Icons.edit_note_rounded,
          onPressed: () {
            _editPlaylist(context, playlist['name'], songs,  songController);
          }),
    );
  }

  //
  //
 Future<void> _editPlaylist(
    BuildContext context, String playlistName, List<SongsModel> currentSongs,SongController songController ) async {
  Get.to(() => SongPickerScreen(
        audioFiles: songController.audioFiles,
        onSongsSelected: (selectedSongs) async {
          // Update the playlist with the selected songs
          await _updatePlaylist(playlistName, selectedSongs);
          Navigator.pop(context); // Return to the playlist details screen
          Get.snackbar("Success", "Playlist updated successfully");
        },
        initialSelection: currentSongs, // Pass the existing songs
      ))?.then((_) {
        // Refresh the playlist details screen after editing
        // Get.back();
        // Get.to(() => PlaylistDetailsScreen(playlist: playlist));
      });
}

//
//
  Future<void> _updatePlaylist(
      String playlistName, List<SongsModel> songs) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = prefs.getStringList('playlists') ?? [];

    for (int i = 0; i < playlists.length; i++) {
      final playlist = jsonDecode(playlists[i]);
      if (playlist['name'] == playlistName) {
        // Update the songs in the playlist
        playlist['songs'] = songs.map((song) => song.toJson()).toList();
        playlists[i] = jsonEncode(playlist);
        await prefs.setStringList('playlists', playlists);
        return;
      }
    }
  }

//
//
Future<void> _deletePlaylist(BuildContext context, String playlistName) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = prefs.getStringList('playlists') ?? [];

    // Remove the playlist with the matching name
    playlists.removeWhere((json) {
      final playlist = jsonDecode(json);
      return playlist['name'] == playlistName;
    });

    // Save the updated playlists back to SharedPreferences
    await prefs.setStringList('playlists', playlists);

    // Show a success message and navigate back
    Get.snackbar("Success", "Playlist '$playlistName' deleted successfully");
    Navigator.pop(context); // Return to the previous screen
  }
}
