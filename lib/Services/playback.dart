import 'package:audiobookshelf/Model/library_items_response/chapter.dart';
import 'package:audiobookshelf/Model/playback_session/audio_track.dart';
import 'package:audiobookshelf/Model/playback_session/playback_session.dart';

class PlaybackSessionManager {
  PlaybackSession session;
  double currentTime = 0.0;
  late List<Chapter> chapters;

  PlaybackSessionManager(this.session) {
    currentTime = session.currentTime;
    chapters = chaptersWithEnoughDuration();
    print(chapters);
  }

  set setCurrentTime(double time) {
    currentTime = time;
  }

  // from chapters remove any chapter where end-start < 2 keep the order
  List<Chapter> chaptersWithEnoughDuration() {
    return session.chapters
        .where((element) => (element.end - element.start) > 2)
        .toList();
  }

  AudioTrack? getCurrentAudioTrack() {
    for (var element in session.audioTracks) {
      if (currentTime >= element.startOffset &&
          currentTime < element.startOffset + element.duration) {
        return element;
      }
    }
    return null;
  }

  Chapter? getCurrentChapter() {
    for (var element in chapters) {
      if (currentTime < element.end) {
        return element;
      }
    }
    return null;
  }

  Chapter? getNextChapter(Chapter currentChapter) {
    final index = chapters.indexOf(currentChapter);
    if (index == chapters.length - 1) {
      return null;
    }
    return chapters[index + 1];
  }

  AudioTrack? getNextAudioTrack(AudioTrack currentTrack) {
    final index = session.audioTracks.indexOf(currentTrack);
    if (index == session.audioTracks.length - 1) {
      return null;
    }
    return session.audioTracks[index + 1];
  }

  Chapter? getPreviousChapter(Chapter value) {
    final index = chapters.indexOf(value);
    if (index == 0) {
      return null;
    }
    return chapters[index - 1];
  }
}
