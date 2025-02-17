import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mymusic/app/home/component/customer_drawer.dart';
import 'package:mymusic/components/common_inkwell.dart';
import 'package:mymusic/utils/constants.dart';
import 'package:mymusic/utils/time_format.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart' as path;

import '../../components/common_text.dart';
import '../../components/empty_card_big.dart';
import '../../components/empty_card_small.dart';
import '../../components/home_album_card.dart';
import '../../components/neu_container.dart';
import '../../components/shimmer_card_small.dart';
import '../../components/shimmer_card_square.dart';
import '../../components/slide_down_animate.dart';
import '../../components/slide_up_animate.dart';
import '../../utils/permission_handler.dart';
import '../../utils/theme_controller.dart';
import '../album/album_screen.dart';
import '../song_screen.dart';
import 'component/feature_song_card.dart';
import 'component/home_title.dart';
import 'component/song_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final themeController = Get.find<ThemeController>();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _audioFiles = [];
  Map<String, List<SongModel>> _audioFolders = {};
  bool _isFileLoading = true;
  bool _isFolderLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAudioFiles();
    _loadAudioFolders();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    bool _isDarkMode = themeController.isDarkMode.value;

    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: "Home", fontSize: 22),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_rounded),
              visualDensity: VisualDensity.compact),
          IconButton(
              onPressed: () {},
              icon: Icon(Icons.info_rounded),
              visualDensity: VisualDensity.compact)
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 20),
              // ShimmerCardSquare(),
              // EmptyCardSmall(),
              // EmptyCardBig(),
              // ShimmerCardSmall(),
              // ShimmerCardBig(),
              SizedBox(height: 20),
              _isFileLoading
                  ? ShimmerCardSmall()
                  : _audioFiles.isEmpty
                      ? EmptyCardBig()
                      : SlideDownAnimate(
                        delay: 300,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  _audioFiles.length > 1 ? 1 : _audioFiles.length,
                              itemBuilder: (context, index) {
                                final audioFile = _audioFiles[index];
                                return featureSongCard(
                                    audioFile: audioFile, isDarkMode: _isDarkMode);
                              }),
                        ],
                      ),
              const SizedBox(height: 20),
              HomeTitle(
                text: "Albums",
                onPress: () {
                  Get.to(()=>AlbumScreen());
                },
              ),
              // const SizedBox(height: 20),
              _isFolderLoading
                  ? Container(
                      height: 160,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: ListView.builder(
                          itemCount: 8,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ShimmerCardSquare();
                          }),
                    )
                  : _audioFolders.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: EmptyCardBig(),
                        )
                      : SlideDownAnimate(
                        delay: 400,
                        children: [
                          Container(
                              height: 160,
                              // color: red,
                              child: ListView.builder(
                                  itemCount: _audioFolders.length > 4
                                  ? 4
                                  : _audioFolders.length,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index) {
                                    var items = albumData[index];
                                    String folderName =
                                        _audioFolders.keys.elementAt(index);
                                    List<SongModel> folderFiles =
                                        _audioFolders[folderName]!;
                                    return Row(
                                      children: [
                                        const SizedBox(width: 15),
                                        HomeAlbumCard(
                                            folderName: folderName,
                                            image: items["image"],
                                            itemCount: folderFiles.length.toString(),
                                            onPress: () {}),
                                        index == albumData.length - 1
                                            ? const SizedBox(width: 15)
                                            : const SizedBox(width: 0)
                                      ],
                                    );
                                  }),
                            ),
                        ],
                      ),
              const SizedBox(height: 10),
              HomeTitle(text: "Songs", onPress: () {
                  Get.to(()=>SongScreen());
                }),
              const SizedBox(height: 20),
              _isFileLoading
                  ? ShimmerCardSmall()
                  : _audioFiles.isEmpty
                      ? EmptyCardSmall()
                      : SlideUpAnimate(
                        delay: 400,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              // itemCount: _audioFiles.length,
                             itemCount: _audioFiles.length > 6
                                  ? 6
                                  : _audioFiles.length,
                              itemBuilder: (context, index) {
                                final audioFile = _audioFiles[index];
                                return Column(
                                  children: [
                                    SongListItem(
                                      name: audioFile.title,
                                      duration: formatDurationMilliseconds(
                                          audioFile.duration ?? 0),
                                      onPress: () {},
                                    ),
                                    const SizedBox(height: 13),
                                  ],
                                );
                              }),
                        ],
                      ),
              const SizedBox(height: 20),
            ]),
      ),
    );
  }

//
//--------------- Custom Functions
//

  List<Map<String?, dynamic>> albumData = [
    {"name": "Downloads", "image": "assets/images/cover04.jpg"},
    {"name": "Musics", "image": "assets/images/cover02.jpg"},
    {"name": "Songs", "image": "assets/images/cover03.jpg"},
    {"name": "Album Name 123 XYZ", "image": "assets/images/cover01.jpg"}
  ];

//
//------------------------------ Custom Functions
//
  Future<void> _loadAudioFiles() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files using on_audio_query
        final audioFiles = await _audioQuery.querySongs(
          sortType: SongSortType.DATE_ADDED,
          orderType: OrderType.DESC_OR_GREATER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );

        setState(() {
          _audioFiles = audioFiles;
          _isFileLoading = false;
        });
      } catch (e) {
        print('Failed to fetch audio files: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  // ------------------------------ Fetch Audio Folders

  Future<void> _loadAudioFolders() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files
        final audioFiles = await _audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );
        Map<String, List<SongModel>> folders = {};
        for (var audioFile in audioFiles) {
          String folderPath =
              path.dirname(audioFile.data); // Extract folder path
          String folderName = path.basename(folderPath); // Extract folder name

          if (!folders.containsKey(folderName)) {
            folders[folderName] = [];
          }
          folders[folderName]!.add(audioFile);
        }

        setState(() {
          _audioFolders = folders;
          _isFolderLoading = false;
        });
      } catch (e) {
        print('Failed to fetch audio folders: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission denied')),
      );
    }
  }
}


