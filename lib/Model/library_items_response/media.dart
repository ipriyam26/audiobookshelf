import 'dart:convert';

import 'package:collection/collection.dart';

import 'audio_file.dart';
import 'chapter.dart';
import 'metadata.dart';
import 'track.dart';

class Media {
  String? libraryItemId;
  Metadata metadata;
  String? coverPath;
  List<String>? tags;
  List<AudioFile>? audioFiles;
  List<Chapter>? chapters;
  double? duration;
  int? size;
  List<Track>? tracks;
  List<dynamic>? missingParts;
  dynamic ebookFile;

  Media({
    required this.libraryItemId,
    required this.metadata,
    this.coverPath,
    this.tags,
    this.audioFiles,
    this.chapters,
    this.duration,
    this.size,
    this.tracks,
    this.missingParts,
    this.ebookFile,
  });

  factory Media.empty() => Media(
        libraryItemId: "",
        metadata: Metadata.empty(),
        coverPath: "",
        tags: [],
        audioFiles: [],
        chapters: [],
        duration: 0,
        size: 0,
        tracks: [],
        missingParts: [],
        ebookFile: "",
      );

  @override
  String toString() {
    return 'Media(libraryItemId: $libraryItemId, metadata: $metadata, coverPath: $coverPath, tags: $tags, audioFiles: $audioFiles, chapters: $chapters, duration: $duration, size: $size, tracks: $tracks, missingParts: $missingParts, ebookFile: $ebookFile)';
  }

  factory Media.fromMap(Map<String, dynamic> data) => Media(
        libraryItemId: data['libraryItemId'] as String?,
        metadata: Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
        coverPath: data['coverPath'] as String?,
        tags: ((data['tags'] as List<dynamic>?) ?? []).map((e) => e as String).toList(),
        audioFiles: (data['audioFiles'] as List<dynamic>?)
            ?.map((e) => AudioFile.fromMap(e as Map<String, dynamic>))
            .toList(),
        chapters: (data['chapters'] as List<dynamic>?)
            ?.map((e) => Chapter.fromMap(e as Map<String, dynamic>))
            .toList(),
        duration: (data['duration'] as num?)?.toDouble(),
        size: data['size'] as int?,
        tracks: (data['tracks'] as List<dynamic>?)
            ?.map((e) => Track.fromMap(e as Map<String, dynamic>))
            .toList(),
        missingParts: data['missingParts'] as List<dynamic>?,
        ebookFile: data['ebookFile'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'libraryItemId': libraryItemId,
        'metadata': metadata.toMap(),
        'coverPath': coverPath,
        'tags': tags,
        'audioFiles': audioFiles?.map((e) => e.toMap()).toList(),
        'chapters': chapters?.map((e) => e.toMap()).toList(),
        'duration': duration,
        'size': size,
        'tracks': tracks?.map((e) => e.toMap()).toList(),
        'missingParts': missingParts,
        'ebookFile': ebookFile,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Media].
  factory Media.fromJson(String data) {
    return Media.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Media] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Media) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      libraryItemId.hashCode ^
      metadata.hashCode ^
      coverPath.hashCode ^
      tags.hashCode ^
      audioFiles.hashCode ^
      chapters.hashCode ^
      duration.hashCode ^
      size.hashCode ^
      tracks.hashCode ^
      missingParts.hashCode ^
      ebookFile.hashCode;

  String formatDuration({bool? english = false}) {
    try {
      final int totalSeconds = duration!.toInt();
      final int hours = totalSeconds ~/ 3600;
      final int minutes = (totalSeconds % 3600) ~/ 60;
      final int seconds = totalSeconds % 60;

      if (english!) {
        return hours > 0
            ? "$hours hr ${minutes.toString().padLeft(2, '0')} min"
            : "$minutes min ${seconds.toString().padLeft(2, '0')} sec";
      }

      return hours > 0
          ? "$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}"
          : "$minutes:${seconds.toString().padLeft(2, '0')}";
    } catch (_) {
      return "";
    }
  }
}
