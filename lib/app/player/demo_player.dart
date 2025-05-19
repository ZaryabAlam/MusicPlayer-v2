import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:rxdart/rxdart.dart";

import "../../models/position_data.dart";
import "../../utils/constants.dart";
import "../../utils/player_controls.dart";

class DemoPlayer extends StatefulWidget {
  const DemoPlayer({super.key});

  @override
  State<DemoPlayer> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DemoPlayer> {
  late AudioPlayer _audioPlayer;

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferPosition, duration) =>
            PositionData(position, bufferPosition, duration ?? Duration.zero),
      );

  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.asset("assets/audio/audio01.mp3",
        tag: MediaItem(
            id: "0",
            title: "Asset Music 01",
            artist: "Artist 01",
            artUri: Uri.parse("assets/images/song01.jpg"))),
    AudioSource.asset("assets/audio/audio02.mp3",
        tag: MediaItem(
            id: "1",
            title: "Asset Music 02",
            artist: "Artist 02",
            artUri: Uri.parse("assets/images/song02.jpg"))),
    AudioSource.asset("assets/audio/audio03.mp3",
        tag: MediaItem(
            id: "2",
            title: "Asset Music 03",
            artist: "Artist 03",
            artUri: Uri.parse("assets/images/song03.jpg")))
  ]);

  Future<void> init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playlist);
  }

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    init();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey.shade600, Colors.blueGrey.shade900])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                if (state?.sequence.isEmpty ?? true) {
                  return SizedBox();
                }
                final metadata = state!.currentSource!.tag as MediaItem;
                return MediaMetaData(
                    imageUrl: metadata.artUri.toString(),
                    title: metadata.title.toString(),
                    artist: metadata.artist.toString());
              }),
          StreamBuilder(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  baseBarColor: grey.withOpacity(0.1),
                  progressBarColor: primaryAppColor,
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: _audioPlayer.seek,
                  thumbColor: Colors.transparent,
                );
              }),
          Controls(audioPlayer: _audioPlayer)
        ],
      ),
    ));
  }
}

//
// //
//
class MediaMetaData extends StatelessWidget {
  const MediaMetaData(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.artist});

  final String imageUrl;
  final String title;
  final String artist;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(2, 4), blurRadius: 4),
          ], borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage(imageUrl),
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(artist,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))
      ],
    );
  }
}
