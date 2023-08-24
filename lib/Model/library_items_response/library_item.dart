import 'dart:convert';

import 'package:collection/collection.dart';

import 'library_file.dart';
import 'media.dart';

class LibraryItem {
  String? id;
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
  Media? media;
  List<LibraryFile>? libraryFiles;
  int? size;

  LibraryItem({
    this.id,
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
    this.media,
    this.libraryFiles,
    this.size,
  });

  @override
  String toString() {
    return 'LibraryItem(id: $id, ino: $ino, libraryId: $libraryId, folderId: $folderId, path: $path, relPath: $relPath, isFile: $isFile, mtimeMs: $mtimeMs, ctimeMs: $ctimeMs, birthtimeMs: $birthtimeMs, addedAt: $addedAt, updatedAt: $updatedAt, lastScan: $lastScan, scanVersion: $scanVersion, isMissing: $isMissing, isInvalid: $isInvalid, mediaType: $mediaType, media: $media, libraryFiles: $libraryFiles, size: $size)';
  }

  factory LibraryItem.fromMap(Map<String, dynamic> data) => LibraryItem(
        id: data['id'] as String?,
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
        media: data['media'] == null
            ? null
            : Media.fromMap(data['media'] as Map<String, dynamic>),
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
        'media': media?.toMap(),
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
}
