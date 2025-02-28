import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/Common_empty_card.dart';
import '../../components/common_text.dart';

import '../../components/shimmer_card_small.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player/controller.dart/audio_player_controller.dart';
import '../player/player_screen.dart';
import 'controller/favorite_controller.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final audioPlayerController = Get.find<AudioPlayerController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    favoriteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: CommonText(text: "Favorite", fontSize: 22),
        ),
        // body: _favorites.isEmpty
        body: favoriteController.isLoading.value
            ? ListView.builder(
                itemCount: 8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ShimmerCardSmall(),
                  );
                })
            : favoriteController.favoriteList.isEmpty
                ? Center(
                    child: CommonEmptyCard(text: "No Favorite Item Found!"),
                  )
                : ListView.builder(
                    itemCount: favoriteController.favoriteList.length,
                    itemBuilder: (context, index) {
                      final song = favoriteController.favoriteList[index];
                      return Dismissible(
                        key: Key(song.id.toString()),
                        confirmDismiss: (direction) async {
                          // _removeFromFavorites(song.id.toString());
                          await favoriteController
                              .removeFavorite(song.id.toString());
                          await favoriteController.getFavorites();
                        },
                        child: Column(
                          children: [
                            index == 0
                                ? const SizedBox(height: 20)
                                : const SizedBox(height: 0),
                            SongListItem(
                                name: song.title,
                                duration: formatDurationMilliseconds(
                                    song.duration ?? 0),
                                onPress: () {
                                  audioPlayerController.audioFiles.assignAll(
                                      favoriteController.favoriteList);
                                  audioPlayerController.currentIndex.value =
                                      index;
                                  Get.to(() => PlayerScreen(
                                      reset: true,
                                      audioFiles:
                                          favoriteController.favoriteList,
                                      currentIndex: index));
                                }),
                            index == favoriteController.favoriteList.length - 1
                                ? const SizedBox(height: 20)
                                : const SizedBox(height: 15)
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
