import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:radioseiboapp/providers/player_provider.dart';
import 'package:radioseiboapp/styles/colors.dart';
import 'package:radioseiboapp/widgets/buttons_player.dart';

class PlayerRadioSeybo extends StatefulWidget {
  const PlayerRadioSeybo({super.key});

  @override
  State<PlayerRadioSeybo> createState() => _PlayerRadioSeyboState();
}

class _PlayerRadioSeyboState extends State<PlayerRadioSeybo> {
  @override
  Widget build(BuildContext context) {
    return context.watch<PlayerProvider>().audioHandler != null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primaryBlueWithTransparent),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Play/pause/stop buttons.
                      ButtonsPlayer(),
                    ],
                  ),
                ),
              ],
            ),
          )
        : const Center(
            child: Text("El reproductor no pudo cargar"),
          );
  }
}
