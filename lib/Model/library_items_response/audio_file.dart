import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/audio_metadata.dart';
import 'package:collection/collection.dart';

import 'meta_tags.dart';

class AudioFile {
  int? index;
  String? ino;
  AudioMetadata? metadata;
  int? addedAt;
  int? updatedAt;
  int? trackNumFromMeta;
  dynamic discNumFromMeta;
  int? trackNumFromFilename;
  dynamic discNumFromFilename;
  bool? manuallyVerified;
  bool? invalid;
  bool? exclude;
  dynamic error;
  String? format;
  double? duration;
  int? bitRate;
  dynamic language;
  String? codec;
  String? timeBase;
  int? channels;
  String? channelLayout;
  List<dynamic>? chapters;
  dynamic embeddedCoverArt;
  MetaTags? metaTags;
  String? mimeType;

  AudioFile({
    this.index,
    this.ino,
    this.metadata,
    this.addedAt,
    this.updatedAt,
    this.trackNumFromMeta,
    this.discNumFromMeta,
    this.trackNumFromFilename,
    this.discNumFromFilename,
    this.manuallyVerified,
    this.invalid,
    this.exclude,
    this.error,
    this.format,
    this.duration,
    this.bitRate,
    this.language,
    this.codec,
    this.timeBase,
    this.channels,
    this.channelLayout,
    this.chapters,
    this.embeddedCoverArt,
    this.metaTags,
    this.mimeType,
  });

  @override
  String toString() {
    return 'AudioFile(index: $index, ino: $ino, metadata: $metadata, addedAt: $addedAt, updatedAt: $updatedAt, trackNumFromMeta: $trackNumFromMeta, discNumFromMeta: $discNumFromMeta, trackNumFromFilename: $trackNumFromFilename, discNumFromFilename: $discNumFromFilename, manuallyVerified: $manuallyVerified, invalid: $invalid, exclude: $exclude, error: $error, format: $format, duration: $duration, bitRate: $bitRate, language: $language, codec: $codec, timeBase: $timeBase, channels: $channels, channelLayout: $channelLayout, chapters: $chapters, embeddedCoverArt: $embeddedCoverArt, metaTags: $metaTags, mimeType: $mimeType)';
  }

  factory AudioFile.fromMap(Map<String, dynamic> data) => AudioFile(
        index: data['index'] as int?,
        ino: data['ino'] as String?,
        metadata: data['metadata'] == null
            ? null
            : AudioMetadata.fromMap(data['metadata'] as Map<String, dynamic>),
        addedAt: data['addedAt'] as int?,
        updatedAt: data['updatedAt'] as int?,
        trackNumFromMeta: data['trackNumFromMeta'] as int?,
        discNumFromMeta: data['discNumFromMeta'] as dynamic,
        trackNumFromFilename: data['trackNumFromFilename'] as int?,
        discNumFromFilename: data['discNumFromFilename'] as dynamic,
        manuallyVerified: data['manuallyVerified'] as bool?,
        invalid: data['invalid'] as bool?,
        exclude: data['exclude'] as bool?,
        error: data['error'] as dynamic,
        format: data['format'] as String?,
        duration: (data['duration'] as num?)?.toDouble(),
        bitRate: data['bitRate'] as int?,
        language: data['language'] as dynamic,
        codec: data['codec'] as String?,
        timeBase: data['timeBase'] as String?,
        channels: data['channels'] as int?,
        channelLayout: data['channelLayout'] as String?,
        chapters: data['chapters'] as List<dynamic>?,
        embeddedCoverArt: data['embeddedCoverArt'] as dynamic,
        metaTags: data['metaTags'] == null
            ? null
            : MetaTags.fromMap(data['metaTags'] as Map<String, dynamic>),
        mimeType: data['mimeType'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'index': index,
        'ino': ino,
        'metadata': metadata?.toMap(),
        'addedAt': addedAt,
        'updatedAt': updatedAt,
        'trackNumFromMeta': trackNumFromMeta,
        'discNumFromMeta': discNumFromMeta,
        'trackNumFromFilename': trackNumFromFilename,
        'discNumFromFilename': discNumFromFilename,
        'manuallyVerified': manuallyVerified,
        'invalid': invalid,
        'exclude': exclude,
        'error': error,
        'format': format,
        'duration': duration,
        'bitRate': bitRate,
        'language': language,
        'codec': codec,
        'timeBase': timeBase,
        'channels': channels,
        'channelLayout': channelLayout,
        'chapters': chapters,
        'embeddedCoverArt': embeddedCoverArt,
        'metaTags': metaTags?.toMap(),
        'mimeType': mimeType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AudioFile].
  factory AudioFile.fromJson(String data) {
    return AudioFile.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AudioFile] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AudioFile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      index.hashCode ^
      ino.hashCode ^
      metadata.hashCode ^
      addedAt.hashCode ^
      updatedAt.hashCode ^
      trackNumFromMeta.hashCode ^
      discNumFromMeta.hashCode ^
      trackNumFromFilename.hashCode ^
      discNumFromFilename.hashCode ^
      manuallyVerified.hashCode ^
      invalid.hashCode ^
      exclude.hashCode ^
      error.hashCode ^
      format.hashCode ^
      duration.hashCode ^
      bitRate.hashCode ^
      language.hashCode ^
      codec.hashCode ^
      timeBase.hashCode ^
      channels.hashCode ^
      channelLayout.hashCode ^
      chapters.hashCode ^
      embeddedCoverArt.hashCode ^
      metaTags.hashCode ^
      mimeType.hashCode;
}
