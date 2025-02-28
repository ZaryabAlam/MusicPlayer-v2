// ignore_for_file: must_be_immutable

import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:mymusic/components/neu_container.dart";
import "package:mymusic/utils/constants.dart";
import "package:rxdart/rxdart.dart" as rxdart;

import "../../models/position_data.dart";
import "../../utils/player_controls.dart";
import "../favorite/controller/favorite_controller.dart";
import "controller.dart/audio_player_controller.dart";

class PlayerScreen extends StatefulWidget {
  final List<dynamic> audioFiles;
  final int currentIndex;
  bool? reset = false;

  PlayerScreen({
    Key? key,
    required this.audioFiles,
    required this.currentIndex,
    this.reset,
  }) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final FavoriteController favoriteController = Get.put(FavoriteController());
  final AudioPlayerController audioPlayerController =
      Get.put(AudioPlayerController());

  late AudioPlayer _audioPlayer;
  bool _isFavorite = false;
  Stream<PositionData> get _positionDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferPosition, duration) =>
            PositionData(position, bufferPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    // _audioPlayer = AudioPlayer();
    _audioPlayer = Get.find<AudioPlayerController>().audioPlayer;
    _initAudioPlayer();
    _checkIfFavorite();
  }

  @override
  void dispose() async {
    // _audioPlayer.dispose();
    favoriteController.getFavorites();
    Future.delayed(Duration(milliseconds: 1), () {
      audioPlayerController.dismissMainPlayer();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      // getBack();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
                IconButton(
                  onPressed: _toggleFavorite,
                  icon: Icon(
                    _isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: _isFavorite ? primaryAppColor : grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.shade400, width: 2)),
                    child: NeuContainer(
                        padding: 0,
                        radius: 180,
                        child: Image(
                            height: 180,
                            width: 180,
                            image: AssetImage("assets/icons/record.png"),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(height: 30),
                  StreamBuilder<SequenceState?>(
                    stream: _audioPlayer.sequenceStateStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data;
                      if (state?.currentSource == null) {
                        return Text("Loading...");
                      }
                      final mediaItem = state!.currentSource!.tag as MediaItem;
                      return Column(
                        children: [
                          Text(
                            mediaItem.title,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Text(
                            mediaItem.album ?? 'Unknown',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: StreamBuilder(
                        stream: _positionDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;
                          return ProgressBar(
                              barCapShape: BarCapShape.round,
                              progress: positionData?.position ?? Duration.zero,
                              buffered:
                                  positionData?.bufferPosition ?? Duration.zero,
                              total: positionData?.duration ?? Duration.zero,
                              onSeek: _audioPlayer.seek,
                              thumbColor: Colors.transparent);
                        }),
                  ),
                  Controls(audioPlayer: _audioPlayer),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  //
  //--------------------------------- Custom Functions
  //
  Future<void> _initAudioPlayer() async {
    Future.delayed(Duration(milliseconds: 1), () {
      audioPlayerController.showMainPlayer();
      audioPlayerController.showMiniPlayer();
    });
    try {
      if ((_audioPlayer.sequence?.isEmpty ?? true) || (widget.reset == true)) {
        final playlist = ConcatenatingAudioSource(
          children: widget.audioFiles.map((audioFile) {
            return AudioSource.uri(
              Uri.parse(audioFile.uri),
              tag: MediaItem(
                id: audioFile.id.toString(),
                title: audioFile.title,
                artist: audioFile.artist,
                album: audioFile.album,
              ),
            );
          }).toList(),
        );

        await _audioPlayer.setAudioSource(playlist,
            initialIndex: widget.currentIndex);
        await _audioPlayer.play();
      }
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  //
  //

  Future<void> _checkIfFavorite() async {
    final currentSongId = widget.audioFiles[widget.currentIndex].id.toString();
    final isFav = await favoriteController.isFavorite(currentSongId);
    setState(() {
      _isFavorite = isFav;
    });
  }

  //
  //

  Future<void> _toggleFavorite() async {
    final currentSong = widget.audioFiles[widget.currentIndex];
    final songData = {
      'id': currentSong.id.toString(),
      'title': currentSong.title,
      'artist': currentSong.artist,
      'album': currentSong.album,
      'uri': currentSong.uri,
      'duration': currentSong.duration,
    };

    if (_isFavorite) {
      await favoriteController.removeFavorite(currentSong.id.toString());
    } else {
      await favoriteController.addFavorite(songData);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
}
