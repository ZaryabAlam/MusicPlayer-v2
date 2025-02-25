import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic/components/neu_container.dart';

import '../../components/common_text.dart';
import '../../components/empty_card_small.dart';
import '../../components/shimmer_card_small.dart';
import '../../controllers/theme_controller.dart';
import '../../utils/constants.dart';
import '../../utils/time_format.dart';
import '../home/component/song_list_item.dart';
import '../player_screen.dart';
import '../song/controller/song_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SongController songController = Get.put(SongController());
  TextEditingController searchController = TextEditingController();
  final themeController = Get.find<ThemeController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    songController.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkmode = themeController.isDarkMode.value;
    return Obx(() => Scaffold(
          appBar: AppBar(title: CommonText(text: "Search", fontSize: 22)),
          body: Column(
            children: [
              NeuContainer(
                  margin: 10,
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          height: 40,
                          child: TextField(
                            controller: searchController,
                            onChanged: (query) {
                              songController.filterSongs(query);
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: isDarkmode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade100,
                              hintStyle: TextStyle(color: grey, fontSize: 12),
                              hintText: "Search",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: isDarkmode
                                        ? Colors.grey.shade600
                                        : Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: isDarkmode
                                        ? Colors.grey.shade700
                                        : Colors.grey.shade400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              songController.isLoading.value
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ShimmerCardSmall(),
                            );
                          }),
                    )
                  : songController.filteredAudioFiles.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: EmptyCardSmall())
                      : Expanded(
                          child: ListView.builder(
        itemCount: songController.filteredAudioFiles.length,
        itemBuilder: (context, index) {
          final audioFile = songController.filteredAudioFiles[index];
          return Column(
            children: [
              index == 0
                  ? const SizedBox(height: 10)
                  : const SizedBox(height: 0),
              SongListItem(
                name: audioFile.title,
                duration: formatDurationMilliseconds(audioFile.duration ?? 0),
                onPress: () {
                  Get.to(() => PlayerScreen(
                        audioFiles: songController.filteredAudioFiles,
                        currentIndex: index,
                      ));
                },
              ),
              index == songController.filteredAudioFiles.length - 1
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 15),
            ],
          );})
                        ),
            ],
          ),
        ));
  }
}
