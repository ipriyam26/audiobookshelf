import 'dart:convert';

import 'package:collection/collection.dart';

import 'metadata.dart';

class Track {
  int? index;
  double? startOffset;
  double? duration;
  String? title;
  String? contentUrl;
  String? mimeType;
  Metadata? metadata;

  Track({
    this.index,
    this.startOffset,
    this.duration,
    this.title,
    this.contentUrl,
    this.mimeType,
    this.metadata,
  });

  @override
  String toString() {
    return 'Track(index: $index, startOffset: $startOffset, duration: $duration, title: $title, contentUrl: $contentUrl, mimeType: $mimeType, metadata: $metadata)';
  }

  factory Track.fromMap(Map<String, dynamic> data) => Track(
        index: data['index'] as int?,
        startOffset: (data['startOffset'] as num?)?.toDouble(),
        duration: (data['duration'] as num?)?.toDouble(),
        title: data['title'] as String?,
        contentUrl: data['contentUrl'] as String?,
        mimeType: data['mimeType'] as String?,
        metadata: data['metadata'] == null
            ? null
            : Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'index': index,
        'startOffset': startOffset,
        'duration': duration,
        'title': title,
        'contentUrl': contentUrl,
        'mimeType': mimeType,
        'metadata': metadata?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Track].
  factory Track.fromJson(String data) {
    return Track.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Track] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Track) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      index.hashCode ^
      startOffset.hashCode ^
      duration.hashCode ^
      title.hashCode ^
      contentUrl.hashCode ^
      mimeType.hashCode ^
      metadata.hashCode;
}
