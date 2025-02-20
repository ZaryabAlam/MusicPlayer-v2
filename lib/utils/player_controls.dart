import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mymusic/components/common_inkwell.dart';
import 'package:mymusic/components/neu_container.dart';

import 'constants.dart';

class Controls extends StatefulWidget {
  const Controls({
    super.key,
    required this.audioPlayer,
  });

  final AudioPlayer audioPlayer;

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  bool _isShuffleEnabled = false;
  LoopMode _loopMode = LoopMode.off;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            // Toggle shuffle mode
            setState(() {
              _isShuffleEnabled = !_isShuffleEnabled;
              widget.audioPlayer.setShuffleModeEnabled(_isShuffleEnabled);
            });
          },
          iconSize: 20,
          icon: Icon(
            Icons.shuffle_rounded,
            color: _isShuffleEnabled ? primaryAppColor : grey,
          ),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2)),
          child: CommonInkwell(
            space: 5,
            child: Icon(Icons.skip_previous_rounded, size: 25),
            onPress: () {
              widget.audioPlayer.seekToPrevious();
            },
          ),
        ),
        SizedBox(width: 10),
        StreamBuilder<PlayerState>(
          stream: widget.audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;

            // Handle play/pause button logic
            if (!(playing ?? false)) {
              return NeuContainer(
                radius: 80,
                padding: 0,
                child: CommonInkwell(
                  radius: 80,
                  child: Icon(Icons.play_arrow_rounded, size: 60),
                  onPress: () {
                    if (processingState == ProcessingState.completed) {
                      // If the song has finished, reset to the beginning
                      widget.audioPlayer.seek(Duration.zero);
                    }
                    widget.audioPlayer.play();
                  },
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return NeuContainer(
                radius: 80,
                padding: 0,
                child: CommonInkwell(
                  radius: 80,
                  child: Icon(Icons.pause_rounded, size: 60),
                  onPress: () {
                    widget.audioPlayer.pause();
                  },
                ),
              );
            }
            return NeuContainer(
              radius: 80,
              padding: 0,
              child: CommonInkwell(
                radius: 80,
                child: Icon(Icons.play_arrow_rounded, size: 60),
                onPress: () {
                  if (processingState == ProcessingState.completed) {
                    // If the song has finished, reset to the beginning
                    widget.audioPlayer.seek(Duration.zero);
                  }
                  widget.audioPlayer.play();
                },
              ),
            );
          },
        ),
        SizedBox(width: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2)),
          child: CommonInkwell(
            space: 5,
            child: Icon(Icons.skip_next_rounded, size: 25),
            onPress: () {
              widget.audioPlayer.seekToNext();
            },
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            setState(() {
              switch (_loopMode) {
                case LoopMode.off:
                  _loopMode = LoopMode.all; // Loop through the entire playlist
                  break;
                case LoopMode.all:
                  _loopMode = LoopMode.one; // Repeat the current song
                  break;
                case LoopMode.one:
                  _loopMode = LoopMode.off; // Disable looping
                  break;
              }
              widget.audioPlayer.setLoopMode(_loopMode);
            });
          },
          iconSize: 20,
          icon: Icon(
            _getRepeatIcon(), // Dynamically change the icon based on the loop mode
            color:
                _getRepeatIconColor(), // Highlight the icon when looping is enabled
          ),
        ),
      ],
    );
  }


  IconData _getRepeatIcon() {
    switch (_loopMode) {
      case LoopMode.off:
        return Icons.repeat_rounded;
      case LoopMode.all:
        return Icons.repeat_rounded;
      case LoopMode.one:
        return Icons.repeat_one_rounded;
    }
  }

  Color _getRepeatIconColor() {
    return _loopMode == LoopMode.off ? grey : primaryAppColor;
  }
}
