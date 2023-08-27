import 'dart:convert';

import 'package:collection/collection.dart';

class AudioMetadata {
  String? filename;
  String? ext;
  String? path;
  String? relPath;
  int? size;
  int? mtimeMs;
  int? ctimeMs;
  int? birthtimeMs;

  AudioMetadata({
    this.filename,
    this.ext,
    this.path,
    this.relPath,
    this.size,
    this.mtimeMs,
    this.ctimeMs,
    this.birthtimeMs,
  });

  @override
  String toString() {
    return 'AudioMetadata(filename: $filename, ext: $ext, path: $path, relPath: $relPath, size: $size, mtimeMs: $mtimeMs, ctimeMs: $ctimeMs, birthtimeMs: $birthtimeMs)';
  }

  factory AudioMetadata.fromMap(Map<String, dynamic> data) => AudioMetadata(
        filename: data['filename'] as String?,
        ext: data['ext'] as String?,
        path: data['path'] as String?,
        relPath: data['relPath'] as String?,
        size: data['size'] as int?,
        mtimeMs: data['mtimeMs'] as int?,
        ctimeMs: data['ctimeMs'] as int?,
        birthtimeMs: data['birthtimeMs'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'filename': filename,
        'ext': ext,
        'path': path,
        'relPath': relPath,
        'size': size,
        'mtimeMs': mtimeMs,
        'ctimeMs': ctimeMs,
        'birthtimeMs': birthtimeMs,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AudioMetadata].
  factory AudioMetadata.fromJson(String data) {
    return AudioMetadata.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AudioMetadata] to a JSON string.
  String toJson() => json.encode(toMap());

  AudioMetadata copyWith({
    String? filename,
    String? ext,
    String? path,
    String? relPath,
    int? size,
    int? mtimeMs,
    int? ctimeMs,
    int? birthtimeMs,
  }) {
    return AudioMetadata(
      filename: filename ?? this.filename,
      ext: ext ?? this.ext,
      path: path ?? this.path,
      relPath: relPath ?? this.relPath,
      size: size ?? this.size,
      mtimeMs: mtimeMs ?? this.mtimeMs,
      ctimeMs: ctimeMs ?? this.ctimeMs,
      birthtimeMs: birthtimeMs ?? this.birthtimeMs,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AudioMetadata) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      filename.hashCode ^
      ext.hashCode ^
      path.hashCode ^
      relPath.hashCode ^
      size.hashCode ^
      mtimeMs.hashCode ^
      ctimeMs.hashCode ^
      birthtimeMs.hashCode;
}
