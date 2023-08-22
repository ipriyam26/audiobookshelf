import 'dart:convert';

class MediaProgress {
  String? id;
  String? libraryItemId;
  String? episodeId;
  double? duration;
  double? progress;
  double? currentTime;
  bool? isFinished;
  bool? hideFromContinueListening;
  int? lastUpdate;
  int? startedAt;
  dynamic finishedAt;

  MediaProgress({
    this.id,
    this.libraryItemId,
    this.episodeId,
    this.duration,
    this.progress,
    this.currentTime,
    this.isFinished,
    this.hideFromContinueListening,
    this.lastUpdate,
    this.startedAt,
    this.finishedAt,
  });

  @override
  String toString() {
    return 'MediaProgress(id: $id, libraryItemId: $libraryItemId, episodeId: $episodeId, duration: $duration, progress: $progress, currentTime: $currentTime, isFinished: $isFinished, hideFromContinueListening: $hideFromContinueListening, lastUpdate: $lastUpdate, startedAt: $startedAt, finishedAt: $finishedAt)';
  }

  factory MediaProgress.fromMap(Map<String, dynamic> data) => MediaProgress(
        id: data['id'] as String?,
        libraryItemId: data['libraryItemId'] as String?,
        episodeId: data['episodeId'] as String?,
        duration: (data['duration'] as num?)?.toDouble(),
        progress: (data['progress'] as num?)?.toDouble(),
        currentTime: (data['currentTime'] as num?)?.toDouble(),
        isFinished: data['isFinished'] as bool?,
        hideFromContinueListening: data['hideFromContinueListening'] as bool?,
        lastUpdate: data['lastUpdate'] as int?,
        startedAt: data['startedAt'] as int?,
        finishedAt: data['finishedAt'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'libraryItemId': libraryItemId,
        'episodeId': episodeId,
        'duration': duration,
        'progress': progress,
        'currentTime': currentTime,
        'isFinished': isFinished,
        'hideFromContinueListening': hideFromContinueListening,
        'lastUpdate': lastUpdate,
        'startedAt': startedAt,
        'finishedAt': finishedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MediaProgress].
  factory MediaProgress.fromJson(String data) {
    return MediaProgress.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MediaProgress] to a JSON string.
  String toJson() => json.encode(toMap());
}
