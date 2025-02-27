import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mymusic/utils/constants.dart';

import "package:rxdart/rxdart.dart" as rxdart;

import '../../components/common_text.dart';
import '../../components/neu_container.dart';
import '../../controllers/theme_controller.dart';
import 'controller.dart/audio_player_controller.dart';
import 'player_screen.dart';

class MiniPlayer extends StatelessWidget {
  final AudioPlayer audioPlayer;

  const MiniPlayer({Key? key, required this.audioPlayer}) : super(key: key);

  Stream<PositionData> get _positionDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferPosition, duration) =>
            PositionData(position, bufferPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    bool isDarkmode = themeController.isDarkMode.value;
    final audioPlayerController = Get.find<AudioPlayerController>();

    return StreamBuilder<SequenceState?>(
      stream: audioPlayer.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state?.currentSource == null) {
          return SizedBox.shrink(); 
        }

        final mediaItem = state!.currentSource!.tag as MediaItem;

        return Material(
          color: transparent,
          child: GestureDetector(
            onTap: () {
              Get.to(() => PlayerScreen(
                  audioFiles:
                      audioPlayerController.audioFiles,
                  currentIndex: audioPlayerController.currentIndex.value));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PlayerScreen(
              //       audioFiles: [], // Pass your audio files here
              //       currentIndex: 0, // Pass the current index here
              //     ),
              //   ),
              // );
            },
            child: NeuContainer(
              bgColor: isDarkmode ? Colors.grey.shade900 : Colors.grey.shade200,
              margin: 10,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset("assets/icons/record.png",
                          width: 40, height: 40),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: mediaItem.title,
                          fontSize: 14,
                          weight: FontWeight.w600,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis,
                          color:
                              isDarkmode ? Colors.grey.shade400 : Colors.black,
                        ),
                        SizedBox(height: 5),
                        StreamBuilder(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return ProgressBar(
                                  onSeek: audioPlayer.seek,
                                  timeLabelTextStyle: TextStyle(fontSize: 0),
                                  thumbRadius: 0,
                                  thumbCanPaintOutsideBar: false,
                                  thumbGlowColor: transparent,
                                  thumbGlowRadius: 0,
                                  barCapShape: BarCapShape.round,
                                  progress:
                                      positionData?.position ?? Duration.zero,
                                  total:
                                      positionData?.duration ?? Duration.zero,
                                  thumbColor: Colors.transparent);
                            }),
                      ],
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.skip_previous_rounded,
                      color: isDarkmode ? Colors.grey.shade500 : Colors.black54,
                      size: 24,
                    ),
                    onPressed: () {
                      audioPlayer.seekToPrevious();
                    },
                  ),
                  StreamBuilder<PlayerState>(
                    stream: audioPlayer.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      final processingState = playerState?.processingState;
                      final isPlaying =
                          playerState?.playing; // Check if the song is playing
                      if (!(isPlaying ?? false)) {
                        return IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.play_arrow_rounded,
                            color: isDarkmode
                                ? Colors.grey.shade400
                                : Colors.black,
                            size: 34,
                          ),
                          onPressed: () {
                            if (processingState == ProcessingState.completed) {
                              audioPlayer.seek(Duration.zero);
                            }
                            audioPlayer.play();
                          },
                        );
                      } else if (processingState != ProcessingState.completed) {
                        return IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.pause_rounded,
                            color: isDarkmode
                                ? Colors.grey.shade400
                                : Colors.black,
                            size: 34,
                          ),
                          onPressed: () {
                            audioPlayer.pause();
                          },
                        );
                      }
                      return IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color:
                              isDarkmode ? Colors.grey.shade400 : Colors.black,
                          size: 34,
                        ),
                        onPressed: () {
                          if (processingState == ProcessingState.completed) {
                            audioPlayer.seek(Duration.zero);
                          }
                          audioPlayer.play();
                        },
                      );
                    },
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      Icons.skip_next_rounded,
                      color: isDarkmode ? Colors.grey.shade500 : Colors.black54,
                      size: 24,
                    ),
                    onPressed: () {
                      audioPlayer.seekToNext();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
