import 'package:audio_player/model/audio_data.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const AudioPlayerApp());
}

class AudioPlayerApp extends StatelessWidget {
  const AudioPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.dark(),
      home: const AudioPlayerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  AudioPlayer audioPlayer = AudioPlayer();

  /// Index des Audio, das grade abgespielt wird
  int currentIndex = 0;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Currently Playing: ${audioList[currentIndex].title}")),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (currentIndex > 0) {
                      await audioPlayer.stop();
                    
                        setState(() {
                          currentIndex--;
                        });
                        await audioPlayer.play(
                            UrlSource(audioList[currentIndex].audioSource));
                      }
                    
                  },
                  child: const Text('Skip Backward'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } 
                    if(!isPlaying){
                      await audioPlayer.play(UrlSource(audioList[currentIndex].audioSource));
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
                        await audioPlayer.play(
                            UrlSource(audioList[currentIndex].audioSource));
                      } else {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    }
                  },
                  child: const Text('Skip Forward'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
