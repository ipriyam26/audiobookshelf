import 'dart:convert';

import 'package:collection/collection.dart';

import 'file_metadata.dart';

class AudioTrack {
  int? index;
  double? startOffset;
  double? duration;
  String? title;
  String? contentUrl;
  String? mimeType;
  String? codec;
  Metadata? metadata;

  AudioTrack({
    this.index,
    this.startOffset,
    this.duration,
    this.title,
    this.contentUrl,
    this.mimeType,
    this.codec,
    this.metadata,
  });

  @override
  String toString() {
    return 'AudioTrack(index: $index, startOffset: $startOffset, duration: $duration, title: $title, contentUrl: $contentUrl, mimeType: $mimeType, codec: $codec, metadata: $metadata)';
  }

  factory AudioTrack.fromMap(Map<String, dynamic> data) => AudioTrack(
        index: data['index'] as int?,
        startOffset: (data['startOffset'] as num?)?.toDouble(),
        duration: (data['duration'] as num?)?.toDouble(),
        title: data['title'] as String?,
        contentUrl: data['contentUrl'] as String?,
        mimeType: data['mimeType'] as String?,
        codec: data['codec'] as String?,
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
        'codec': codec,
        'metadata': metadata?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AudioTrack].
  factory AudioTrack.fromJson(String data) {
    return AudioTrack.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AudioTrack] to a JSON string.
  String toJson() => json.encode(toMap());

  AudioTrack copyWith({
    int? index,
    double? startOffset,
    double? duration,
    String? title,
    String? contentUrl,
    String? mimeType,
    String? codec,
    Metadata? metadata,
  }) {
    return AudioTrack(
      index: index ?? this.index,
      startOffset: startOffset ?? this.startOffset,
      duration: duration ?? this.duration,
      title: title ?? this.title,
      contentUrl: contentUrl ?? this.contentUrl,
      mimeType: mimeType ?? this.mimeType,
      codec: codec ?? this.codec,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AudioTrack) return false;
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
      codec.hashCode ^
      metadata.hashCode;
}
