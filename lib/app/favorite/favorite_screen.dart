import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic/components/common_text.dart';

import '../../components/empty_card_small.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player_screen.dart';
import 'controller/favorite_manager.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<dynamic> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final List<dynamic> favorites = await FavoriteSongsManager.getFavorites();
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
        title: Text('Favorite Songs'),
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
                return Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          _removeFromFavorites(song["id"]);
                        },
                        icon: Icon(Icons.delete)),
                    CommonText(text: song.toString()),
                    SongListItem(
                      name: song['title'],
                      duration:
                          formatDurationMilliseconds(song['duration'] ?? 0),
                      onPress: () {
                        Get.to(() => PlayerScreen(
                              audioFiles:
                                  _favorites,
                              currentIndex: index,
                            ));
                      },
                    ),
                  ],
                );
                //                           ListTile(
                //   leading: QueryArtworkWidget(
                //     id: int.parse(song['id']),
                //     type: ArtworkType.AUDIO,
                //     nullArtworkWidget: Icon(Icons.music_note),
                //   ),
                //   title: Text(song['title']),
                //   subtitle: Text(song['artist'] ?? 'Unknown Artist'),
                //   trailing: IconButton(
                //     icon: Icon(Icons.delete),
                //     onPressed: () {
                //       _removeFromFavorites(song['id']);
                //     },
                //   ),
                //   onTap: () {
                //     // Navigate to the PlayerScreen with the favorite song list
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => PlayerScreen(
                //           audioFiles: _favorites,
                //           currentIndex: index,
                //         ),
                //       ),
                //     );
                //   },
                // );
              },
            ),
    );
  }
}
