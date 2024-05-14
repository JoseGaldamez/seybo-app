import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioseiboapp/providers/player_provider.dart';

class TitlePlayer extends StatelessWidget {
  final bool playing;
  const TitlePlayer({super.key, required this.playing});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: context.watch<PlayerProvider>().audioHandler!.mediaItem,
      builder: (context, snapshot) {
        final mediaItem = snapshot.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mediaItem?.title ?? '',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              playing ? 'En vivo' : 'En línea',
              style: const TextStyle(color: Colors.white),
            )
          ],
        );
      },
    );
  }
}
