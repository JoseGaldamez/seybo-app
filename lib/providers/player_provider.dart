import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class PlayerProvider with ChangeNotifier {
  AudioHandler? _audioHandler;
  AudioHandler? get audioHandler => _audioHandler;

  void setAudioHandler(AudioHandler handler) {
    _audioHandler = handler;
    notifyListeners();
  }
}
