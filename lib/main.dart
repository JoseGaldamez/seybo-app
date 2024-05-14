import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radioseiboapp/controllers/audio_handler.dart';
import 'package:radioseiboapp/providers/player_provider.dart';
import 'package:radioseiboapp/styles/colors.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';
// https://radioseibo.dominicos.org:8443/radio.ogg

late AudioHandler? _audioHandler;

Future<void> main() async {
  try {
    _audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId:
            'org.radioseibo.radioseiboapp.channel.audio',
        androidNotificationChannelName: 'Radio Seybo en Vivo',
        androidNotificationOngoing: true,
      ),
    );
  } catch (e) {
    _audioHandler = null;
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PlayerProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Radio Seibo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
        useMaterial3: true,
      ),
      home: HomeScreen(
        audioHandler: _audioHandler,
      ),
    );
  }
}
