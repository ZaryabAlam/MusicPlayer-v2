import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  RxBool isMiniPlayerVisible = false.obs;
  RxBool isMainPlayer = false.obs;
  RxList audioFiles = [].obs; // List of audio files
  RxInt currentIndex = 0.obs; // Current index of the playing song

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  Future<void> dismissMiniPlayer() async {
    audioPlayer.pause();
    isMiniPlayerVisible.value = false;
    update();
  }

  Future<void> showMiniPlayer() async {
    isMiniPlayerVisible.value = true;
    update();
  }

  Future<void> showMainPlayer() async {
    isMainPlayer.value = true;
    update();
  }

  Future<void> dismissMainPlayer() async {
    isMainPlayer.value = false;
    update();
  }
}
