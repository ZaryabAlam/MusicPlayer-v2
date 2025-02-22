import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path/path.dart' as path;

import '../../../components/gradient_snackbar.dart';
import '../../../models/song_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/permission_handler.dart';

class HomeController extends GetxController {
  RxBool isFileLoading = true.obs;
  RxBool isFolderLoading = true.obs;
  final OnAudioQuery audioQuery = OnAudioQuery();
  RxList<SongsModel> audioFiles = <SongsModel>[].obs;
  RxMap<dynamic, dynamic> audioFolders = {}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAudioFiles();
    _loadAudioFolders();
  }

  Future<void> _loadAudioFiles() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files using on_audio_query
        final List<SongModel> _audioFiles = await audioQuery.querySongs(
          sortType: SongSortType.DATE_ADDED,
          orderType: OrderType.DESC_OR_GREATER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );

        final List<SongsModel> convertedFiles =
            _audioFiles.map((song) => songModelToSongsModel(song)).toList();

        // Assign the converted list to audioFiles
        audioFiles.assignAll(convertedFiles);
      } catch (e) {
        print('Failed to fetch audio files: $e');
      }
    } else {
      Get.showSnackbar(gradientSnackbar("No Permission",
          "Storage permission denied", red, Icons.warning_rounded));
    }
    isFileLoading.value = false;
    update();
  }

  Future<void> _loadAudioFolders() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files
        final _audioFiles = await audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );
        Map<String, List<SongModel>> folders = {};
        for (var _audioFiles in _audioFiles) {
          String folderPath =
              path.dirname(_audioFiles.data);
          String folderName = path.basename(folderPath);

          if (!folders.containsKey(folderName)) {
            folders[folderName] = [];
          }
          folders[folderName]!.add(_audioFiles);
        }
        audioFolders.value = folders;
      } catch (e) {
        print('Failed to fetch audio folders: $e');
      }
    } else {
      Get.showSnackbar(gradientSnackbar("No Permission",
          "Storage permission denied", red, Icons.warning_rounded));
    }
    isFolderLoading.value = false;
    update();
  }
}
