// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/chapter.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/library_items_response/metadata.dart';

import 'package:collection/collection.dart';

import 'audio_track.dart';

import 'device_info.dart';


enum PlaybackMethod { DirectPlay, DirectStream, Transcode, Local }

extension PlaybackMethodExtension on PlaybackMethod {
  int get value {
    return index;
  }

  String get label {
    switch (this) {
      case PlaybackMethod.DirectPlay:
        return 'Direct Play';
      case PlaybackMethod.DirectStream:
        return 'Direct Stream';
      case PlaybackMethod.Transcode:
        return 'Transcode';
      case PlaybackMethod.Local:
        return 'Local';
      default:
        return 'Unknown';
    }
  }

  static PlaybackMethod fromValue(int value) {
    return PlaybackMethod.values[value];
  }
}

class PlaybackSession {
  String id;
  String userId;
  String libraryId;
  String libraryItemId;
  dynamic episodeId;
  String mediaType;
  Metadata mediaMetadata;
  List<Chapter> chapters;
  String displayTitle;
  String displayAuthor;
  String coverPath;
  double duration;
  PlaybackMethod playMethod;
  String mediaPlayer;
  DeviceInfo deviceInfo;
  String date;
  String dayOfWeek;
  int timeListening;
  double startTime;
  double currentTime;
  int startedAt;
  int updatedAt;
  List<AudioTrack> audioTracks;
  dynamic videoTrack;
  LibraryItem libraryItem;

  PlaybackSession({
    required this.id,
    required this.userId,
    required this.libraryId,
    required this.libraryItemId,
    required this.episodeId,
    required this.mediaType,
    required this.mediaMetadata,
    required this.chapters,
    required this.displayTitle,
    required this.displayAuthor,
    required this.coverPath,
    required this.duration,
    required this.playMethod,
    required this.mediaPlayer,
    required this.deviceInfo,
    required this.date,
    required this.dayOfWeek,
    required this.timeListening,
    required this.startTime,
    required this.currentTime,
    required this.startedAt,
    required this.updatedAt,
    required this.audioTracks,
    required this.videoTrack,
    required this.libraryItem,
  });

  @override
  String toString() {
    return 'PlaybackSession(id: $id, userId: $userId, libraryId: $libraryId, libraryItemId: $libraryItemId, episodeId: $episodeId, mediaType: $mediaType, mediaMetadata: $mediaMetadata, chapters: $chapters, displayTitle: $displayTitle, displayAuthor: $displayAuthor, coverPath: $coverPath, duration: $duration, playMethod: $playMethod, mediaPlayer: $mediaPlayer, deviceInfo: $deviceInfo, date: $date, dayOfWeek: $dayOfWeek, timeListening: $timeListening, startTime: $startTime, currentTime: $currentTime, startedAt: $startedAt, updatedAt: $updatedAt, audioTracks: $audioTracks, videoTrack: $videoTrack, libraryItem: $libraryItem)';
  }

  factory PlaybackSession.empty(){
    return PlaybackSession(
      id: '',
      userId: '',
      libraryId: '',
      libraryItemId: '',
      episodeId: '',
      mediaType: '',
      mediaMetadata: Metadata.empty(),
      chapters: [],
      displayTitle: '',
      displayAuthor: '',
      coverPath: '',
      duration: 0.0,
      playMethod: PlaybackMethod.DirectPlay,
      mediaPlayer: '',
      deviceInfo: DeviceInfo.empty(),
      date: '',
      dayOfWeek: '',
      timeListening: 0,
      startTime: 0.0,
      currentTime: 0.0,
      startedAt: 0,
      updatedAt: 0,
      audioTracks: [],
      videoTrack: '',
      libraryItem: LibraryItem.empty(),
    );
  }

  factory PlaybackSession.fromMap(Map<String, dynamic> data) {
    return PlaybackSession(
      id: data['id'] as String,
      userId: data['userId'] as String,
      libraryId: data['libraryId'] as String,
      libraryItemId: data['libraryItemId'] as String,
      episodeId: data['episodeId'] as dynamic,
      mediaType: data['mediaType'] as String,
      mediaMetadata:
          Metadata.fromMap(data['mediaMetadata'] as Map<String, dynamic>),
      chapters: (data['chapters'] as List<dynamic>?)!
          .map((e) => Chapter.fromMap(e as Map<String, dynamic>))
          .toList(),
      displayTitle: data['displayTitle'] as String,
      displayAuthor: data['displayAuthor'] as String,
      coverPath: data['coverPath'] as String,
      duration: (data['duration'] as num).toDouble(),
      playMethod:
          PlaybackMethodExtension.fromValue((data['playMethod'] ?? 0) as int),
      mediaPlayer: data['mediaPlayer'] as String,
      deviceInfo:
          DeviceInfo.fromMap(data['deviceInfo'] as Map<String, dynamic>),
      date: data['date'] as String,
      dayOfWeek: data['dayOfWeek'] as String,
      timeListening: data['timeListening'] as int,
      startTime: (data['startTime'] as num).toDouble(),
      currentTime: (data['currentTime'] as num).toDouble(),
      startedAt: data['startedAt'] as int,
      updatedAt: data['updatedAt'] as int,
      audioTracks: (data['audioTracks'] as List<dynamic>?)!
          .map((e) => AudioTrack.fromMap(e as Map<String, dynamic>))
          .toList(),
      videoTrack: data['videoTrack'] as dynamic,
      libraryItem:
          LibraryItem.fromMap(data['libraryItem'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'libraryId': libraryId,
        'libraryItemId': libraryItemId,
        'episodeId': episodeId,
        'mediaType': mediaType,
        'mediaMetadata': mediaMetadata.toMap(),
        'chapters': chapters.map((e) => e.toMap()).toList(),
        'displayTitle': displayTitle,
        'displayAuthor': displayAuthor,
        'coverPath': coverPath,
        'duration': duration,
        'playMethod': playMethod,
        'mediaPlayer': mediaPlayer,
        'deviceInfo': deviceInfo.toMap(),
        'date': date,
        'dayOfWeek': dayOfWeek,
        'timeListening': timeListening,
        'startTime': startTime,
        'currentTime': currentTime,
        'startedAt': startedAt,
        'updatedAt': updatedAt,
        'audioTracks': audioTracks.map((e) => e.toMap()).toList(),
        'videoTrack': videoTrack,
        'libraryItem': libraryItem.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PlaybackSession].
  factory PlaybackSession.fromJson(String data) {
    return PlaybackSession.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PlaybackSession] to a JSON string.
  String toJson() => json.encode(toMap());

  PlaybackSession copyWith({
    String? id,
    String? userId,
    String? libraryId,
    String? libraryItemId,
    dynamic episodeId,
    String? mediaType,
    Metadata? mediaMetadata,
    List<Chapter>? chapters,
    String? displayTitle,
    String? displayAuthor,
    String? coverPath,
    double? duration,
    PlaybackMethod? playMethod,
    String? mediaPlayer,
    DeviceInfo? deviceInfo,
    String? date,
    String? dayOfWeek,
    int? timeListening,
    double? startTime,
    double? currentTime,
    int? startedAt,
    int? updatedAt,
    List<AudioTrack>? audioTracks,
    dynamic videoTrack,
    LibraryItem? libraryItem,
  }) {
    return PlaybackSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      libraryId: libraryId ?? this.libraryId,
      libraryItemId: libraryItemId ?? this.libraryItemId,
      episodeId: episodeId ?? this.episodeId,
      mediaType: mediaType ?? this.mediaType,
      mediaMetadata: mediaMetadata ?? this.mediaMetadata,
      chapters: chapters ?? this.chapters,
      displayTitle: displayTitle ?? this.displayTitle,
      displayAuthor: displayAuthor ?? this.displayAuthor,
      coverPath: coverPath ?? this.coverPath,
      duration: duration ?? this.duration,
      playMethod: playMethod ?? this.playMethod,
      mediaPlayer: mediaPlayer ?? this.mediaPlayer,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      date: date ?? this.date,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      timeListening: timeListening ?? this.timeListening,
      startTime: startTime ?? this.startTime,
      currentTime: currentTime ?? this.currentTime,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      audioTracks: audioTracks ?? this.audioTracks,
      videoTrack: videoTrack ?? this.videoTrack,
      libraryItem: libraryItem ?? this.libraryItem,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PlaybackSession) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      libraryId.hashCode ^
      libraryItemId.hashCode ^
      episodeId.hashCode ^
      mediaType.hashCode ^
      mediaMetadata.hashCode ^
      chapters.hashCode ^
      displayTitle.hashCode ^
      displayAuthor.hashCode ^
      coverPath.hashCode ^
      duration.hashCode ^
      playMethod.hashCode ^
      mediaPlayer.hashCode ^
      deviceInfo.hashCode ^
      date.hashCode ^
      dayOfWeek.hashCode ^
      timeListening.hashCode ^
      startTime.hashCode ^
      currentTime.hashCode ^
      startedAt.hashCode ^
      updatedAt.hashCode ^
      audioTracks.hashCode ^
      videoTrack.hashCode ^
      libraryItem.hashCode;
}
