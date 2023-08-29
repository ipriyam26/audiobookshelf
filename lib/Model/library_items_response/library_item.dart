import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/audio_file.dart';
import 'package:audiobookshelf/Model/library_items_response/chapter.dart';
import 'package:audiobookshelf/Model/login_response/media_progress.dart';
import 'package:collection/collection.dart';

import 'library_file.dart';
import 'media.dart';

class LibraryItem {
  MediaProgress? mediaProgress;
  String id;
  String? ino;
  String? libraryId;
  String? folderId;
  String? path;
  String? relPath;
  bool? isFile;
  int? mtimeMs;
  int? ctimeMs;
  int? birthtimeMs;
  int? addedAt;
  int? updatedAt;
  int? lastScan;
  String? scanVersion;
  bool? isMissing;
  bool? isInvalid;
  String? mediaType;
  Media media;
  List<LibraryFile>? libraryFiles;
  int? size;

  LibraryItem({
    required this.id,
    this.ino,
    this.libraryId,
    this.folderId,
    this.path,
    this.relPath,
    this.isFile,
    this.mtimeMs,
    this.ctimeMs,
    this.birthtimeMs,
    this.addedAt,
    this.updatedAt,
    this.lastScan,
    this.scanVersion,
    this.isMissing,
    this.isInvalid,
    this.mediaType,
    required this.media,
    this.libraryFiles,
    this.size,
  });

  factory LibraryItem.empty() => LibraryItem(
        id: "",
        ino: "",
        libraryId: "",
        folderId: "",
        path: "",
        relPath: "",
        isFile: false,
        mtimeMs: 0,
        ctimeMs: 0,
        birthtimeMs: 0,
        addedAt: 0,
        updatedAt: 0,
        lastScan: 0,
        scanVersion: "",
        isMissing: false,
        isInvalid: false,
        mediaType: "",
        media: Media.empty(),
        libraryFiles: [],
        size: 0,
      );
  @override
  String toString() {
    return 'LibraryItem(id: $id, ino: $ino, libraryId: $libraryId, folderId: $folderId, path: $path, relPath: $relPath, isFile: $isFile, mtimeMs: $mtimeMs, ctimeMs: $ctimeMs, birthtimeMs: $birthtimeMs, addedAt: $addedAt, updatedAt: $updatedAt, lastScan: $lastScan, scanVersion: $scanVersion, isMissing: $isMissing, isInvalid: $isInvalid, mediaType: $mediaType, media: $media, libraryFiles: $libraryFiles, size: $size)';
  }

  factory LibraryItem.fromMap(Map<String, dynamic> data) => LibraryItem(
        id: data['id'] as String,
        ino: data['ino'] as String?,
        libraryId: data['libraryId'] as String?,
        folderId: data['folderId'] as String?,
        path: data['path'] as String?,
        relPath: data['relPath'] as String?,
        isFile: data['isFile'] as bool?,
        mtimeMs: data['mtimeMs'] as int?,
        ctimeMs: data['ctimeMs'] as int?,
        birthtimeMs: data['birthtimeMs'] as int?,
        addedAt: data['addedAt'] as int?,
        updatedAt: data['updatedAt'] as int?,
        lastScan: data['lastScan'] as int?,
        scanVersion: data['scanVersion'] as String?,
        isMissing: data['isMissing'] as bool?,
        isInvalid: data['isInvalid'] as bool?,
        mediaType: data['mediaType'] as String?,
        media: Media.fromMap(data['media'] as Map<String, dynamic>),
        libraryFiles: (data['libraryFiles'] as List<dynamic>?)
            ?.map((e) => LibraryFile.fromMap(e as Map<String, dynamic>))
            .toList(),
        size: data['size'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'ino': ino,
        'libraryId': libraryId,
        'folderId': folderId,
        'path': path,
        'relPath': relPath,
        'isFile': isFile,
        'mtimeMs': mtimeMs,
        'ctimeMs': ctimeMs,
        'birthtimeMs': birthtimeMs,
        'addedAt': addedAt,
        'updatedAt': updatedAt,
        'lastScan': lastScan,
        'scanVersion': scanVersion,
        'isMissing': isMissing,
        'isInvalid': isInvalid,
        'mediaType': mediaType,
        'media': media.toMap(),
        'libraryFiles': libraryFiles?.map((e) => e.toMap()).toList(),
        'size': size,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LibraryItem].
  factory LibraryItem.fromJson(String data) {
    return LibraryItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LibraryItem] to a JSON string.
  String toJson() => json.encode(toMap());

// add mediaProgress to LibraryItem
  setMediaProgress(MediaProgress mediaProgress) {
    this.mediaProgress = mediaProgress;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LibraryItem) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      ino.hashCode ^
      libraryId.hashCode ^
      folderId.hashCode ^
      path.hashCode ^
      relPath.hashCode ^
      isFile.hashCode ^
      mtimeMs.hashCode ^
      ctimeMs.hashCode ^
      birthtimeMs.hashCode ^
      addedAt.hashCode ^
      updatedAt.hashCode ^
      lastScan.hashCode ^
      scanVersion.hashCode ^
      isMissing.hashCode ^
      isInvalid.hashCode ^
      mediaType.hashCode ^
      media.hashCode ^
      libraryFiles.hashCode ^
      size.hashCode;

  String get title => media.metadata.title ?? "Failed to Load";
  List<AudioFile> get audioFiles => media.audioFiles ?? [];
  List<Chapter> get chapterList => media.chapters ?? [];
  String get itemProgress =>
      "Your Progress:  ${(mediaProgress!.progress! * 100).toInt()}%";

  String get authorName =>
      media.metadata.authors != null && media.metadata.authors!.isNotEmpty
          ? media.metadata.authors![0].name ?? ""
          : media.metadata.authorName ?? "";

  String get narratorNames =>
      media.metadata.narrators != null && media.metadata.narrators!.isNotEmpty
          ? media.metadata.narrators![0]
          : media.metadata.narratorName ?? "";

  String get description => media.metadata.description ?? "";

  String get genreNames => (media.metadata.genres ?? []).join(", ");
  String get serieNames =>
      (media.metadata.series ?? []).map((e) => e.name).join(", ");

  String get publishedYear => (media.metadata.publishedYear ?? "").toString();

  Map<String, int> convertToHours(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    return {'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  String getDuration() {
    try {
      final int totalSeconds =
          media.duration!.floor(); // Convert to nearest lower integer
      final Map<String, int> time = convertToHours(totalSeconds);
      final hour = time["hours"];
      final minutes = time["minutes"];
      return '$hour hr $minutes min';
    } catch (e) {
      return "Not able to process";
    }
  }

  String getCoverUrl(String server, String token, {bool? raw}) {
    if (raw != null && raw) {
      return "$server/api/items/$id/cover?token=$token&raw=${1}";
    }
    return "$server/api/items/$id/cover?token=$token";
  }
}
