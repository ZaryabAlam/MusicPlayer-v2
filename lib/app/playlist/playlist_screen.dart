
import "package:flutter/material.dart";
import "package:get/get.dart";

import "package:mymusic/utils/constants.dart";
import "../../components/Common_empty_card.dart";
import "../../components/common_outline_button.dart";
import "../../components/common_text.dart";
import "../../components/gradient_FAB.dart";
import "../../components/shimmer_card_small.dart";
import "../../controllers/theme_controller.dart";
import "../song/controller/song_controller.dart";
import "component/playlist_card.dart";
import "controller/playlist_controller.dart";
import "playlist_detail_screen.dart";
import "playlist_picker_screen.dart";

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final SongController songController = Get.put(SongController());
  final PlaylistController playlistController = Get.put(PlaylistController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    songController.dispose();
    playlistController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: CommonText(text: "Playlist", fontSize: 22)),
        body: playlistController.isLoading.value
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
            : playlistController.playlist.isEmpty
                ? Center(
                    child: CommonEmptyCard(text: "No Playlist Found!"),
                  )
                : ListView.builder(
                    itemCount: playlistController.playlist.length,
                    itemBuilder: (context, index) {
                      final playlist = playlistController.playlist[index];
                      return Column(
                        children: [
                          index == 0
                              ? const SizedBox(height: 20)
                              : const SizedBox(height: 0),
                          Dismissible(
                            key: Key(playlist['name']),
                            confirmDismiss: (direction) async {
                              await playlistController.deletePlaylist(
                                  context, playlist['name']);
                            },
                            child: PlaylistCard(
                              name: playlist['name'].toString().capitalizeFirst,
                              items: playlist['songs'].length.toString(),
                              onPress: () {
                                    Get.to(() =>
                                    PlaylistDetailsScreen(playlist: playlist));
                              },
                            ),
                          ),
                          index == playlistController.playlist.length - 1
                              ? const SizedBox(height: 20)
                              : const SizedBox(height: 15)
                        ],
                      );
                    },
                  ),
        floatingActionButton: GradientOutlineFAB(
            icon: Icons.add_rounded,
            onPressed: () {
              // _createPlaylistDialog(context);
              playlistBottomDialog(context);
            }),
      ),
    );
  }

//
//
  Future<void> playlistBottomDialog(BuildContext context) async {
    String playlistName = '';
    final themeController = Get.find<ThemeController>();
    bool isDarkmode = themeController.isDarkMode.value;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Material(
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonText(
                          text: "Create Playlist",
                          weight: FontWeight.w400,
                          fontSize: 22),
                      SizedBox(height: 15),
                      TextField(
                        onChanged: (value) {
                          playlistName = value;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: isDarkmode
                              ? Colors.grey.shade800
                              : Colors.grey.shade100,
                          hintStyle: TextStyle(color: grey),
                          hintText: "Enter playlist name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: isDarkmode
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                width: 1.5,
                                color: isDarkmode
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade400),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonOutlineButton(
                              height: 40,
                              width: 100,
                              onPress: () {
                                if (playlistName.trim().isEmpty) {
                                  Get.snackbar(
                                      "Error", "Playlist name cannot be empty");
                                  return;
                                }
                                Navigator.pop(context, playlistName);
                              },
                              text: "Create"),
                          SizedBox(width: 10),
                          CommonOutlineButton(
                              height: 40,
                              width: 100,
                              onPress: () {
                                Navigator.pop(context);
                              },
                              text: "Cancel",
                              outlineColor: [
                                secondaryAppColor,
                                secondaryAppColor,
                              ])
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then((result) {
      if (result != null) {
        _pickSongsForPlaylist(result as String);
      }
    });
  }

//
//
  // Future<void> _createPlaylistDialog(BuildContext context) async {
  //   String playlistName = '';
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Create Playlist"),
  //       content: TextField(
  //         onChanged: (value) {
  //           playlistName = value;
  //         },
  //         decoration: InputDecoration(hintText: "Enter playlist name"),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             if (playlistName.trim().isEmpty) {
  //               Get.snackbar("Error", "Playlist name cannot be empty");
  //               return;
  //             }
  //             Navigator.pop(context, playlistName);
  //           },
  //           child: Text("Create"),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: Text("Cancel"),
  //         ),
  //       ],
  //     ),
  //   ).then((result) {
  //     if (result != null) {
  //       _pickSongsForPlaylist(result as String);
  //     }
  //   });
  // }

//
//
  Future<void> _pickSongsForPlaylist(String playlistName) async {
    Get.to(() => SongPickerScreen(
          audioFiles: songController.audioFiles,
          onSongsSelected: (songs) async {
            Get.back();
            await playlistController.savePlaylist(playlistName, songs);
          },
        ));
  }

//
//
  // Future<void> _savePlaylist(String playlistName, List<dynamic> songs) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final playlists = prefs.getStringList('playlists') ?? [];
  //   // Serialize the playlist data
  //   final playlistData = {
  //     'name': playlistName,
  //     'songs': songs.map((song) => song.toJson()).toList()
  //   };
  //   playlists.add(jsonEncode(playlistData));
  //   await prefs.setStringList('playlists', playlists);
  //   Get.snackbar("Success", "Playlist '$playlistName' created successfully");
  // }

//
  //
  // Future<List<dynamic>> _getPlaylists() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final playlists = prefs.getStringList('playlists') ?? [];
  //   return playlists.map((json) => jsonDecode(json)).toList();
  // }

//
//
  // Future<void> _deletePlaylist(
  //     BuildContext context, String playlistName) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final playlists = prefs.getStringList('playlists') ?? [];
  //   playlists.removeWhere((json) {
  //     final playlist = jsonDecode(json);
  //     return playlist['name'] == playlistName;
  //   });
  //   await prefs.setStringList('playlists', playlists);
  //   Get.snackbar("Success", "Playlist '$playlistName' deleted successfully");
  // }
}
