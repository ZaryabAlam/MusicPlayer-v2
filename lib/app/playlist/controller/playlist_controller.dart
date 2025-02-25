import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/song_model.dart';
import '../../song/controller/song_controller.dart';
import '../playlist_picker_screen.dart';
import '../playlist_screen.dart';

class PlaylistController extends GetxController {
  RxBool isLoading = true.obs;
  RxList playlist = [].obs;

  @override
  void onInit() {
    super.onInit();
    getPlaylists();
  }

  // Get all playlist
  Future<void> getPlaylists() async {
    final prefs = await SharedPreferences.getInstance();
    final _playlists = prefs.getStringList('playlists') ?? [];
    final List<Map<String, dynamic>> decodedPlaylists = _playlists
        .map((json) => jsonDecode(json) as Map<String, dynamic>)
        .toList();
    playlist.assignAll(decodedPlaylists);
    isLoading.value = false;
    update();
  }

  // Delete current playlist
  Future<void> deletePlaylist(BuildContext context, String playlistName) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = prefs.getStringList('playlists') ?? [];
    playlists.removeWhere((json) {
      final playlist = jsonDecode(json);
      return playlist['name'] == playlistName;
    });
    await prefs.setStringList('playlists', playlists);
    Get.snackbar("Success", "Playlist '$playlistName' deleted successfully");
    await getPlaylists();
    update();
  }

  // Save the playlist
    Future<void> savePlaylist(String playlistName, List<dynamic> songs) async {
    final prefs = await SharedPreferences.getInstance();
    final playlists = prefs.getStringList('playlists') ?? [];
    final playlistData = {
      'name': playlistName,
      'songs': songs.map((song) => song.toJson()).toList()
    };
    playlists.add(jsonEncode(playlistData));
    await prefs.setStringList('playlists', playlists);
    Get.snackbar("Success", "Playlist '$playlistName' created successfully");
    await getPlaylists();
    update();
  }

  // Edit the playlist
    Future<void> editPlaylist(BuildContext context, String playlistName,
      List<SongsModel> currentSongs, SongController songController) async {
    Get.to(() => SongPickerScreen(
          audioFiles: songController.audioFiles,
          onSongsSelected: (selectedSongs) async {
            // Update the playlist with the selected songs
            await updatePlaylist(playlistName, selectedSongs);
            // Navigator.pop(context); // Return to the playlist details screen
            await getPlaylists();
            Get.back();
             Get.back();
            Get.snackbar("Success", "Playlist updated successfully");
          },
          initialSelection: currentSongs, // Pass the existing songs
        ))?.then((_) {
      // Refresh the playlist details screen after editing
      // Get.back();
      // Get.to(() => PlaylistDetailsScreen(playlist: playlist));
    });
  }

  // Update the playlist
    Future<void> updatePlaylist(
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
}
