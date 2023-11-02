import 'package:audio_player/controls.dart';
import 'package:audio_player/media_meta_data.dart';
import 'package:audio_player/positionData.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio_cache/just_audio_cache.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;

  final _playlist = ConcatenatingAudioSource(
    children: [
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/tovelo.mp3'),
        tag: MediaItem(
          id: 'Tovelo',
          title: 'Talking Bodies',
          artist: 'Tovelo',
          album: 'Tovelo',
          artUri: Uri.parse(
            'https://www.laut.de/Tove-Lo/tove-lo-159533.jpg',
          ),
        ),
      ),
      AudioSource.uri(
        Uri.parse('asset:///assets/audio/laserboy.mp3'),
        tag: MediaItem(
          id: 'Tovelo',
          title: 'Talking Bodies',
          artist: 'Tovelo',
          album: 'Tovelo',
          artUri: Uri.parse(
            'https://www.laut.de/Tove-Lo/tove-lo-159533.jpg',
          ),
        ),
      ),
    ],
  );

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(
          position,
          bufferedPosition,
          duration ?? Duration.zero,
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer()..dynamicSet(url: 'assets/audio/tovelo.mp3');
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setAudioSource(_playlist);
    await _audioPlayer.setLoopMode(LoopMode.all);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 154, 142, 175),
              Color.fromARGB(255, 18, 13, 29),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: _audioPlayer.sequenceStateStream,
                builder: (ctx, snapshot) {
                  final state = snapshot.data as SequenceState?;
                  final metadata = state?.currentSource?.tag as MediaItem?;
                  if (state?.sequence.isEmpty ?? true) {
                    return const SizedBox();
                  }
                  return MediaMetaData(
                    imageUrl: metadata?.artUri.toString() ?? '',
                    title: metadata?.title ?? '',
                    artist: metadata?.artist ?? '',
                  );
                },
              ),
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (ctx, snapshot) {
                  final positionData = snapshot.data;
                  return ProgressBar(
                    baseBarColor: Colors.grey,
                    progressBarColor: Color.fromARGB(255, 18, 13, 29),
                    barHeight: 8,
                    thumbRadius: 8,
                    thumbColor: Colors.white,
                    thumbGlowColor: Colors.white,
                    timeLabelLocation: TimeLabelLocation.below,
                    timeLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _audioPlayer.seek,
                  );
                },
              ),
              Controls(
                audioPlayer: _audioPlayer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
