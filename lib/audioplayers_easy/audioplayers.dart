import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const AudioPlayerApp());
}

class AudioPlayerApp extends StatelessWidget {
  const AudioPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AudioPlayerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> audioList = [
    'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3',
    'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample2.mp3',
    'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.wav'
  ];
  int currentIndex = 0;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("currently Playing: ${audioList[currentIndex]}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (currentIndex > 0) {
                      await audioPlayer.stop();
                      if (isPlaying) {
                        setState(() {
                          currentIndex--;
                        });
                        await audioPlayer
                            .play(UrlSource(audioList[currentIndex]));
                      } else {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    }
                  },
                  child: Text('Skip Backward'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer
                          .play(UrlSource(audioList[currentIndex]));
                    }
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                  child: Text(isPlaying ? 'Pause' : 'Play'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (currentIndex < audioList.length - 1) {
                      await audioPlayer.stop();

                      if (isPlaying) {
                        setState(() {
                          currentIndex++;
                        });
                        await audioPlayer
                            .play(UrlSource(audioList[currentIndex]));
                      } else {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    }
                  },
                  child: Text('Skip Forward'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
