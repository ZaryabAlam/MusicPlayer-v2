import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/components/common_inkwell.dart';
import 'package:mymusic/components/neu_container.dart';

class Controls extends StatelessWidget {
  Controls({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              audioPlayer.shuffle();
            },
            iconSize: 20,
            icon: Icon(Icons.shuffle_rounded)),
        Spacer(),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2)),
          child: CommonInkwell(
              space: 0,
              child: Icon(Icons.skip_previous_rounded, size: 25),
              onPress: () {
                audioPlayer.seekToPrevious();
              }),
        ),
        SizedBox(width: 10),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            if (!(playing ?? false)) {
              return NeuContainer(
                  radius: 80,
                  padding: 0,
                  child: CommonInkwell(
                      radius: 80,
                      child: Icon(Icons.play_arrow_rounded, size: 40),
                      onPress: () {
                        audioPlayer.play();
                      }));
            } else if (processingState != ProcessingState.completed) {
              return NeuContainer(
                radius: 80,
                padding: 0,
                child: CommonInkwell(
                    radius: 80,
                    child: Icon(Icons.pause_rounded, size: 40),
                    onPress: () {
                      audioPlayer.pause();
                    }),
              );
            }
            return Icon(
              Icons.play_arrow_rounded,
              size: 80,
            );
          },
        ),
        SizedBox(width: 10),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2)),
          child: CommonInkwell(
              space: 0,
              radius: 80,
              child: Icon(Icons.skip_next_rounded, size: 25),
              onPress: () {
                audioPlayer.seekToNext();
              }),
        ),
        Spacer(),
        IconButton(
            onPressed: () {
              audioPlayer.shuffle();
            },
            iconSize: 20,
            icon: Icon(Icons.repeat_rounded)),
      ],
    );
  }
}
