import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/song_model.dart';

class FavoriteController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<SongsModel> favoriteList = <SongsModel>[].obs;
  static const String _favoritesKey = 'favorite_songs';

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  // Get all favorite songs
  Future<void> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    final List<SongsModel> favoriteSongs =
        favorites.map((json) => SongsModel.fromJson(jsonDecode(json))).toList();
    favoriteList.assignAll(favoriteSongs);
    isLoading.value = false;
    update();
  }

  // Remove a song from favorites
  Future<void> removeFavorite(String songId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.removeWhere((json) {
      final song = jsonDecode(json);
      return song['id'] == songId;
    });
    await prefs.setStringList(_favoritesKey, favorites);
    // await getFavorites();
  }

  // Add a song to favorites
  Future<void> addFavorite(Map<String, dynamic> songData) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    final songJson = jsonEncode(songData); // Serialize the song data to JSON
    if (!favorites.contains(songJson)) {
      favorites.add(songJson);
      await prefs.setStringList(_favoritesKey, favorites);
      await getFavorites();
    }
  }

    // Check if a song is in favorites
  Future<bool> isFavorite(String songId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.any((json) {
      final song = jsonDecode(json); // Deserialize the JSON back to a map
      return song['id'] == songId; // Match by song ID
    });
  }
}
