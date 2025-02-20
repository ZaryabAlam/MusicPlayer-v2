import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteSongsManager {
  static const String _favoritesKey = 'favorite_songs';

  // Add a song to favorites
  static Future<void> addFavorite(Map<String, dynamic> songData) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    final songJson = jsonEncode(songData); // Serialize the song data to JSON
    if (!favorites.contains(songJson)) {
      favorites.add(songJson);
      await prefs.setStringList(_favoritesKey, favorites);
    }
  }

  // Remove a song from favorites
  static Future<void> removeFavorite(String songId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    favorites.removeWhere((json) {
      final song = jsonDecode(json); // Deserialize the JSON back to a map
      return song['id'] == songId; // Match by song ID
    });
    await prefs.setStringList(_favoritesKey, favorites);
  }

  // Check if a song is in favorites
  static Future<bool> isFavorite(String songId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.any((json) {
      final song = jsonDecode(json); // Deserialize the JSON back to a map
      return song['id'] == songId; // Match by song ID
    });
  }

  // Get all favorite songs
  static Future<List<dynamic>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_favoritesKey) ?? [];
    return favorites.map((json) => jsonDecode(json)).toList(); // Deserialize all songs
  }
}