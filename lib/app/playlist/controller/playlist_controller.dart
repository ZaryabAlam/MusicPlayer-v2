import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
