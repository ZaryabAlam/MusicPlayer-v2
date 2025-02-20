import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart' as path;

import '../../components/empty_card_big.dart';
import '../../components/home_album_card.dart';
import '../../components/shimmer_card_square.dart';
import 'album_song_screen.dart';
import 'controller/album_controller.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumState();
}

class _AlbumState extends State<AlbumScreen> {
  final AlbumController albumController = Get.put(AlbumController());
  // final OnAudioQuery _audioQuery = OnAudioQuery();
  // Map<String, List<SongModel>> _audioFolders = {};
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _loadAudioFolders();
  }

  @override
  void dispose() {
    super.dispose();
    albumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: Text("Albums")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                albumController.isLoading.value
                    ? GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 0.0,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          5,
                          (index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ShimmerCardSquare(),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    : albumController.audioFolders.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: EmptyCardBig())
                        : GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 0.0,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: List.generate(
                              albumController.audioFolders.length,
                              (index) {
                                String folderName = albumController
                                    .audioFolders.keys
                                    .elementAt(index);
                                List<SongModel> folderFiles =
                                    albumController.audioFolders[folderName]!;
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: HomeAlbumCard(
                                          folderName: folderName,
                                          image: "assets/icons/record.png",
                                          itemCount:
                                              folderFiles.length.toString(),
                                          onPress: () {
                                            Get.to(
                                              () => AlbumSongScreen(
                                                  folderName: folderName,
                                                  folderFiles: folderFiles),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
              ],
            ),
          ),
        ));
  }

//
// ------------------------------ Custom Functions
//

// ------------------------------ Fetch Audio Folders

  // Future<void> _loadAudioFolders() async {
  //   bool hasPermission = await requestStoragePermission();
  //   if (hasPermission) {
  //     try {
  //       // Fetch all audio files
  //       final audioFiles = await _audioQuery.querySongs(
  //         sortType: SongSortType.DISPLAY_NAME,
  //         orderType: OrderType.ASC_OR_SMALLER,
  //         uriType: UriType.EXTERNAL,
  //         ignoreCase: true,
  //       );
  //       Map<String, List<SongModel>> folders = {};
  //       for (var audioFile in audioFiles) {
  //         String folderPath =
  //             path.dirname(audioFile.data); // Extract folder path
  //         String folderName = path.basename(folderPath); // Extract folder name

  //         if (!folders.containsKey(folderName)) {
  //           folders[folderName] = [];
  //         }
  //         folders[folderName]!.add(audioFile);
  //       }

  //       setState(() {
  //         _audioFolders = folders;
  //         _isLoading = false;
  //       });
  //     } catch (e) {
  //       print('Failed to fetch audio folders: $e');
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Storage permission denied')),
  //     );
  //   }
  // }
}
