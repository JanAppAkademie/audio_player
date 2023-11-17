import 'package:just_audio/just_audio.dart';

class AudioData {
  final String album;
  final String title;
  final String? artwork;
  final String? audioSource;

  AudioData({
    this.audioSource,
    required this.album,
    required this.title,
    this.artwork,
  });
}

List audioList = [
  AudioData(
    album: "Sample Album",
    title: "Sample 1",
    artwork: "",
    audioSource:
        'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3',
  ),
  AudioData(
    album: "Sample Album",
    title: "Sample 2",
    artwork: "",
    audioSource:
        'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample2.mp3',
  ),
  AudioData(
    album: "Sample Album",
    title: "Sample 3",
    artwork: "",
    audioSource:
        'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.wav',
  ),
];

/// Playlist für just_audio_examples
final playlist = ConcatenatingAudioSource(children: [
  AudioSource.uri(
    Uri.parse(
        "https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3"),
    tag: AudioData(
      album: "Samples",
      title: "Samples 1",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
  AudioSource.uri(
    Uri.parse(
        'https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample2.mp3'),
    tag: AudioData(
      album: "Samples",
      title: "Sample 2",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
  AudioSource.uri(
    Uri.parse("https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3"),
    tag: AudioData(
      album: "Samples",
      title: "Sample 3",
      artwork:
          "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg",
    ),
  ),
]);
