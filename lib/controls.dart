import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Controls extends StatelessWidget {
  AudioPlayer audioPlayer;
  Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          iconSize: 60,
          color: Colors.white,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return const CircularProgressIndicator();
            } else if (playing != true) {
              return IconButton(
                onPressed: audioPlayer.play,
                icon: const Icon(
                  Icons.play_arrow,
                  size: 60,
                  color: Colors.white,
                ),
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                icon: const Icon(
                  Icons.pause,
                  size: 60,
                  color: Colors.white,
                ),
              );
            } else {
              return IconButton(
                onPressed: () => audioPlayer.seek(Duration.zero),
                icon: const Icon(
                  Icons.replay,
                  size: 60,
                  color: Colors.white,
                ),
              );
            }
          },
        ),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          iconSize: 60,
          color: Colors.white,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
