import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/common_text.dart';
import '../../components/empty_card_small.dart';
import '../../models/song_model.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player_screen.dart';
import 'controller/favorite_manager.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<SongsModel> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final List<SongsModel> favorites = await FavoriteSongsManager.getFavorites();
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeFromFavorites(String songId) async {
    await FavoriteSongsManager.removeFavorite(songId);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: "Favorite", fontSize: 22),
      ),
      body: _favorites.isEmpty
          ? Padding(
              padding: const EdgeInsets.only(top: 20),
              child: EmptyCardSmall(),
            )
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final song = _favorites[index];
                return Dismissible(
                  key: Key(song.id.toString()),
                  confirmDismiss: (direction) async {
                    _removeFromFavorites(song.id.toString());
                  },
                  child: Column(
                    children: [
                      index == 0
                          ? const SizedBox(height: 20)
                          : const SizedBox(height: 0),
                      SongListItem(
                          name: song.title,
                          duration:
                              formatDurationMilliseconds(song.duration ?? 0),
                          onPress: () {
                            Get.to(() => PlayerScreen(
                                  audioFiles: _favorites,
                                  currentIndex: index,
                                ));
                          }),
                      index == _favorites.length - 1
                          ? const SizedBox(height: 20)
                          : const SizedBox(height: 15)
                    ],
                  ),
                );
              },
            ),
    );
  }
}
