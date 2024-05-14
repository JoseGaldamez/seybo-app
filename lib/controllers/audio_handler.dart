import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

/// An [AudioHandler] for playing a single item.
///
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static final _item = MediaItem(
    id: 'https://radioseibo.dominicos.org:8443/radio.ogg',
    //id: 'https://streamingcwsradio30.com:7045//stream?type=http&nocache=300',
    album: "En vivo",
    title: "Radio Seybo",
    artist: "En vivo",
    artUri: Uri.parse(
        'https://udeca.do/Portals/0/ThemePluginPro/uploads/2021/2/25/Logo-Radio-Seybo.jgp.jpg'),
  );

  final _player = AudioPlayer();

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.
    mediaItem.add(_item);
    _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
