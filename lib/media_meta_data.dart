import 'package:flutter/material.dart';

class MediaMetaData extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artist;

  const MediaMetaData({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          artist,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
