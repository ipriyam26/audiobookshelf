import 'dart:async';

import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/chapter.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';

import 'package:audiobookshelf/Model/playback_session/audio_track.dart';
import 'package:audiobookshelf/Model/playback_session/playback_session.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:audiobookshelf/Services/playback.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayerController extends GetxController {
  Rx<LibraryItem> item = LibraryItem.empty().obs;
  Rx<PlaybackSessionManager> playbackSessionManager =
      PlaybackSessionManager(PlaybackSession.empty()).obs;
  Rx<Chapter> currentChapter = Chapter.empty().obs;
  Rx<AudioTrack> currentAudioTrack = AudioTrack.empty().obs;
  RxList<Color> gradientColors = <Color>[
    Get.theme.colorScheme.background,
    Get.theme.colorScheme.outline,
  ].obs;
  AudioPlayer player = AudioPlayer();

  var playerState = PlayerState.stopped.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  UserController userController = Get.find();
  Rx<Duration> chapterProgress = Duration.zero.obs;
  Rx<Duration> trackProgress = Duration.zero.obs;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;
  ApiService apiService = ApiService();

  PlayerController({required LibraryItem item}) {
    this.item.value = item;
  }

  @override
  onInit() async {
    super.onInit();
    PlaybackSession playbackSession = await startPlaybackSession();
    playbackSessionManager.value = PlaybackSessionManager(playbackSession);
    item.value = playbackSession.libraryItem;
    playerState.value = player.state;
    initStreams();
  }

  Future<PlaybackSession> startPlaybackSession() async {
    final response = await apiService.authenticatedPost(
      "api/items/${item.value.id}/play",
      {
        "deviceInfo": {"clientVersion": "0.0.1"},
        "supportedMimeTypes": ["audio/flac", "audio/mpeg", "audio/mp4"]
      },
    );
    final playSession = PlaybackSession.fromMap(response);
    return playSession;
  }

  @override
  void onClose() {
    positionSubscription?.cancel();
    playerCompleteSubscription?.cancel();
    playerStateChangeSubscription?.cancel();
    player.dispose();
    super.onClose();
  }

  Future<void> initStreams() async {
    await initialTrackLoad();
    await audioPlayerSetup();
  }

  Future<void> initialTrackLoad() async {
    var newChapter = playbackSessionManager.value.getCurrentChapter();
    var newTrack = playbackSessionManager.value.getCurrentAudioTrack();
    currentChapter.value = newChapter!;
    currentAudioTrack.value = newTrack!;
    await updatePlayerSource(newTrack);

    double localTrackTime =
        playbackSessionManager.value.currentTime - newTrack.startOffset;
    double localChapterTime =
        playbackSessionManager.value.currentTime - newChapter.start;

    await player.seek(Duration(seconds: localTrackTime.toInt()));

    duration.value = currentChapter.value.duration;
    position.value = Duration(seconds: localChapterTime.toInt());
  }

  Future<void> audioPlayerSetup() async {
    positionSubscription = player.onPositionChanged.listen(onPositionChanged);
    playerCompleteSubscription =
        player.onPlayerComplete.listen(audioTrackFinished);
    playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) {
      playerState.value = state;
    });
  }

  void onPositionChanged(Duration p) {
    // print("position ${position.value.inSeconds}");
    // print("duration ${duration.value.inSeconds}");
    playbackSessionManager.value.currentTime =
        currentAudioTrack.value.startOffset + p.inSeconds.toDouble();
    trackProgress.value = p;
    double localChapterTime =
        playbackSessionManager.value.currentTime - currentChapter.value.start;

    position.value = Duration(seconds: localChapterTime.toInt());
    var newChapter = playbackSessionManager.value.getCurrentChapter();
    if (newChapter != currentChapter.value) {
      currentChapter.value = newChapter!;
      duration.value = currentChapter.value.duration;
    }
  }

  void audioTrackFinished(event) async {
    playerState.value = PlayerState.stopped;
    var newTrack =
        playbackSessionManager.value.getNextAudioTrack(currentAudioTrack.value);
    if (newTrack != null) {
      currentAudioTrack.value = newTrack;
      trackProgress.value = Duration.zero;

      await updatePlayerSource(newTrack);
      await play();
    }
  }

  Future<void> updatePlayerSource(AudioTrack newTrack) async {
    var url =
        "${userController.server.value}${newTrack.contentUrl}?token=${userController.currentUser.value.token!}";

    await player.setSourceUrl(Uri.encodeFull(url));
  }

  Future<void> play() async {
    // print(trackProgress.value.inSeconds);
    if (trackProgress.value.inMilliseconds > 0) {
      await player.seek(trackProgress.value);
    }
    await player.resume();
    playerState.value = PlayerState.playing;
  }

  Future<void> pause() async {
    await player.pause();
    playerState.value = PlayerState.paused;
  }

  Future<void> stop() async {
    await player.stop();
    playerState.value = PlayerState.stopped;
  }

  void nextChapter() async {
    var newChapter =
        playbackSessionManager.value.getNextChapter(currentChapter.value)!;
    currentChapter.value = newChapter;
    duration.value = currentChapter.value.duration;
    position.value = Duration.zero;
    var seekTime = newChapter.start - currentAudioTrack.value.startOffset;
    print("seekTime $seekTime");
    seek(Duration(seconds: seekTime.toInt()));
  }

  void previousChapter() {
    var elapsedTime = position.value.inSeconds;
    if (elapsedTime > 5) {
      // go to start of chapter
      position.value = Duration.zero;
      var seekTime =
          currentChapter.value.start - currentAudioTrack.value.startOffset;
      print("seekTime $seekTime");
      seek(Duration(seconds: seekTime.toInt()));
    } else {
      var newChapter = playbackSessionManager.value
          .getPreviousChapter(currentChapter.value)!;
      print("currentChapter ${currentChapter.value.title}");
      print("previousChapter ${newChapter.title}");
      currentChapter.value = newChapter;
      duration.value = currentChapter.value.duration;
      position.value = Duration.zero;
      var seekTime = newChapter.start - currentAudioTrack.value.startOffset;
      print("seekTime $seekTime");
      seek(Duration(seconds: seekTime.toInt()));
    }
  }

  Future<void> seek(Duration duration) async {
    await pause();
    // Calculate the global seek time
    var globalSeekTime =
        currentAudioTrack.value.startOffset + duration.inSeconds.toDouble();
    // what exact time we have to go in the audiobook
    print("globalSeekTime $globalSeekTime");
    print("CurrentTime ${playbackSessionManager.value.currentTime}");
    // Update the playbackSessionManager.value's current time
    playbackSessionManager.value.currentTime = globalSeekTime;

    // Get the appropriate audio track for the updated time
    var newTrack = playbackSessionManager.value.getCurrentAudioTrack()!;
    print("currentAudioTrack ${currentAudioTrack.value.title}");
    print("newTrack ${newTrack.title}");
    // If the track is different, update it
    if (newTrack.index != currentAudioTrack.value.index) {
      print("AudioTrack change");
      currentAudioTrack.value = newTrack;
      await updatePlayerSource(newTrack);
    }

    // Calculate the local time within the new track
    var localTime = globalSeekTime - newTrack.startOffset;
    print("localTime ${Duration(seconds: localTime.toInt()).formatDuration}");
    // Update track progress
    trackProgress.value = Duration(seconds: localTime.toInt() + 1);

    // Perform the seek operation
    await play();
  }

  void onChange(double v) {
    var absoulteSeekTime = (v * duration.value.inSeconds).round().toDouble();
    var newTime = currentChapter.value.start + absoulteSeekTime;
    // update audiotrack to seek
    var seekTrackDuration = Duration(
        seconds: newTime.toInt() - currentAudioTrack.value.startOffset.toInt());
    seek(seekTrackDuration);
  }

  String get currentChapterTitle => currentChapter.value.title;

  String get coverUrl => item.value.getCoverUrl(
        userController.server.value,
        userController.currentUser.value.token!,
      );

  Future<void> getPallett(ImageProvider imageProvider) async {
    var pallett = await PaletteGenerator.fromImageProvider(
      imageProvider,
    );
    var filteredColors = <Color>[];
    for (var paletteColor in pallett.paletteColors) {
      final color = paletteColor.color;

      // Calculate luminance
      double luminance =
          (0.2126 * color.red + 0.7152 * color.green + 0.0722 * color.blue) /
              255;

      if (luminance < 0.8) {
        // You can adjust the threshold
        filteredColors.add(color);
      }
    }
    if (filteredColors.length > 2) {
      filteredColors = filteredColors.sublist(0, 2);
    }
    gradientColors.value = [
      ...filteredColors,
      Get.theme.colorScheme.background
    ];
  }
}

extension DurationExtension on Duration {
  String get formatDuration {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(inHours);
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return "${twoDigitHours.isNotEmpty && twoDigitHours != '00' ? '$twoDigitHours:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }
}
