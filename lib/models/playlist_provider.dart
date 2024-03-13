import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_player/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: 'Afraid to shoot Strangers',
      albumArtImagePath: 'assets/images/iron_maiden.jpg',
      artistName: 'Iron Maiden',
      audioPath: 'audio/Iron Maiden-Afraid To Shoot Strangers.mp3',
    ),
    Song(
      songName: 'sympathy 4 the grinch',
      albumArtImagePath: 'assets/images/100gecs.jpg',
      artistName: '100 gecs',
      audioPath: 'audio/100 gecs-sympathy 4 the grinch.mp3',
    ),
    Song(
      songName: 'Lights Out',
      albumArtImagePath: 'assets/images/bullshit.jpg',
      artistName: 'Mindless Self Indulgence',
      audioPath: 'audio/Mindless Self Indulgence-Lights Out.mp3',
    )
  ];
  int? _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlating => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
