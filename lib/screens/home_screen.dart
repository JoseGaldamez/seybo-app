import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:radioseiboapp/providers/player_provider.dart';
import 'package:radioseiboapp/widgets/action_topbar_button.dart';
import 'package:radioseiboapp/widgets/logo_image.dart';
import 'package:radioseiboapp/widgets/player_widget.dart';

import '../widgets/list_of_news.dart';

class HomeScreen extends StatefulWidget {
  final AudioHandler? audioHandler;
  const HomeScreen({super.key, required this.audioHandler});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      if (context.read<PlayerProvider>().audioHandler == null &&
          widget.audioHandler != null) {
        context.read<PlayerProvider>().setAudioHandler(widget.audioHandler!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Row(
          children: [
            LogoImage(),
            Text(
              'Radio Seybo',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 99, 67, 19)),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: const [ActionTopBarButton()],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.only(bottom: 100),
              child: const ListOfNews(),
            ),
          ),
          widget.audioHandler != null
              ? const PlayerRadioSeybo()
              : const SizedBox(),
        ],
      ),
    );
  }
}
