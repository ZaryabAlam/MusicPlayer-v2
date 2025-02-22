import "package:flutter/material.dart";
import 'package:get/get.dart';
import '../../components/empty_card_small.dart';
import '../../components/shimmer_card_small.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player_screen.dart';
import 'controller/song_controller.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _PlaylistState();
}

class _PlaylistState extends State<SongScreen> {
  final SongController songController = Get.put(SongController());
  // final OnAudioQuery _audioQuery = OnAudioQuery();
  // List<SongModel> _audioFiles = [];
  // bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // _loadAudioFiles();
  }

  @override
  void dispose() {
    super.dispose();
    songController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(title: Text('Songs')),
          body: Column(
            children: [
              songController.isLoading.value
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
                  : songController.audioFiles.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: EmptyCardSmall(),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: songController.audioFiles.length,
                            itemBuilder: (context, index) {
                              final audioFile =
                                  songController.audioFiles[index];
                              return Column(
                                children: [
                                  index == 0
                                      ? const SizedBox(height: 20)
                                      : const SizedBox(height: 0),
                                  SongListItem(
                                    name: audioFile.title,
                                    duration: formatDurationMilliseconds(
                                        audioFile.duration ?? 0),
                                    onPress: () {
                                      Get.to(() => PlayerScreen(
                                            audioFiles:
                                                songController.audioFiles,
                                            currentIndex: index,
                                          ));
                                    },
                                  ),
                                  index == songController.audioFiles.length - 1
                                      ? const SizedBox(height: 20)
                                      : const SizedBox(height: 15)
                                ],
                              );
                            },
                          ),
                        ),
            ],
          ),
        ));
  }

//
//------------------------------ Custom Functions
//
  // Future<void> _loadAudioFiles() async {
  //   bool hasPermission = await requestStoragePermission();
  //   if (hasPermission) {
  //     try {
  //       // Fetch all audio files using on_audio_query
  //       final audioFiles = await _audioQuery.querySongs(
  //         sortType: SongSortType.DISPLAY_NAME,
  //         orderType: OrderType.DESC_OR_GREATER,
  //         uriType: UriType.EXTERNAL,
  //         ignoreCase: true,
  //       );

  //       setState(() {
  //         _audioFiles = audioFiles;
  //         _isLoading = false;
  //       });
  //     } catch (e) {
  //       print('Failed to fetch audio files: $e');
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Storage permission denied')),
  //     );
  //   }
  // }

//
// ------------------------------ X
//
}
