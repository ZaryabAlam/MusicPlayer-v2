import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../components/gradient_snackbar.dart';
import '../../../utils/constants.dart';
import '../../../utils/permission_handler.dart';

class SongController extends GetxController {
  RxBool isLoading = true.obs;
  final OnAudioQuery audioQuery = OnAudioQuery();
  RxList<dynamic> audioFiles = [].obs;

  @override
  void onInit() {
    super.onInit();
    _loadAudioFiles();
      }

  Future<void> _loadAudioFiles() async {
    bool hasPermission = await requestStoragePermission();
    if (hasPermission) {
      try {
        // Fetch all audio files using on_audio_query
        final _audioFiles = await audioQuery.querySongs(
          sortType: SongSortType.DISPLAY_NAME,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );

        audioFiles.value = _audioFiles;
      } catch (e) {
        print('Failed to fetch audio files: $e');
      }
    } else {
      Get.showSnackbar(gradientSnackbar("No Permission",
          "Storage permission denied", red, Icons.warning_rounded));
    }
    isLoading.value = false;
    update();
  }

}
