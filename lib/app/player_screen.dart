import "package:audio_video_progress_bar/audio_video_progress_bar.dart";
import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:mymusic/components/neu_container.dart";
import "package:rxdart/rxdart.dart";

import "../models/position_data.dart";
import "../utils/player_controls.dart";
import "demo_player.dart";

class PlayerScreen extends StatefulWidget {
  final String audioUri;
  final String title;
  final String? artist;

  const PlayerScreen({
    Key? key,
    required this.audioUri,
    required this.title,
    this.artist,
  }) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferPosition, duration) =>
            PositionData(position, bufferPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    await _audioPlayer.setLoopMode(LoopMode.off);
    try {
      // Load the audio file from its URI
      await _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(
              widget.audioUri), // Use the URI passed from the previous screen
          tag: MediaItem(
            id: widget.audioUri,
            title: widget.title,
            artist: widget.artist,
          ),
        ),
      );
      await _audioPlayer.play();
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade400, width: 2)),
            child: NeuContainer(
                padding: 0,
                radius: 180,
                child: Image(
                    height: 180,
                    width: 180,
                    image: AssetImage("assets/icons/record.png"),
                    fit: BoxFit.contain)),
          ),
          SizedBox(height: 20),
          Text(
            widget.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5),
          Text(
            widget.artist ?? 'Unknown Artist',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          StreamBuilder(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return ProgressBar(
                  barCapShape: BarCapShape.round,
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
    );
  }
}
