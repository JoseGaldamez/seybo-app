import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radioseiboapp/providers/player_provider.dart';
import 'package:radioseiboapp/widgets/title_player.dart';

class ButtonsPlayer extends StatefulWidget {
  const ButtonsPlayer({super.key});

  @override
  State<ButtonsPlayer> createState() => _ButtonsPlayerState();
}

class _ButtonsPlayerState extends State<ButtonsPlayer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: context
          .watch<PlayerProvider>()
          .audioHandler!
          .playbackState
          .map((state) => state.playing)
          .distinct(),
      builder: (context, snapshot) {
        final playing = snapshot.data ?? false;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (playing)
              _button(
                  Icons.stop, context.read<PlayerProvider>().audioHandler!.stop)
            else
              _button(Icons.play_arrow,
                  context.read<PlayerProvider>().audioHandler!.play),
            TitlePlayer(
              playing: playing,
            )
          ],
        );
      },
    );
  }

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
        icon: Icon(iconData),
        iconSize: 64.0,
        onPressed: onPressed,
        color: Colors.white,
      );
}
