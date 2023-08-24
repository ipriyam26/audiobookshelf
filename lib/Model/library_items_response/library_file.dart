import 'dart:convert';

import 'package:collection/collection.dart';

import 'metadata.dart';

class LibraryFile {
  String? ino;
  Metadata? metadata;
  int? addedAt;
  int? updatedAt;
  String? fileType;

  LibraryFile({
    this.ino,
    this.metadata,
    this.addedAt,
    this.updatedAt,
    this.fileType,
  });

  @override
  String toString() {
    return 'LibraryFile(ino: $ino, metadata: $metadata, addedAt: $addedAt, updatedAt: $updatedAt, fileType: $fileType)';
  }

  factory LibraryFile.fromMap(Map<String, dynamic> data) => LibraryFile(
        ino: data['ino'] as String?,
        metadata: data['metadata'] == null
            ? null
            : Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
        addedAt: data['addedAt'] as int?,
        updatedAt: data['updatedAt'] as int?,
        fileType: data['fileType'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'ino': ino,
        'metadata': metadata?.toMap(),
        'addedAt': addedAt,
        'updatedAt': updatedAt,
        'fileType': fileType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LibraryFile].
  factory LibraryFile.fromJson(String data) {
    return LibraryFile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LibraryFile] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LibraryFile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      ino.hashCode ^
      metadata.hashCode ^
      addedAt.hashCode ^
      updatedAt.hashCode ^
      fileType.hashCode;
}
