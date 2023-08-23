import 'dart:convert';

import 'media_progress.dart';
import 'permissions.dart';

class User {
  String? id;
  String? username;
  String? type;
  String? token;
  List<MediaProgress>? mediaProgress;
  List<dynamic>? seriesHideFromContinueListening;
  List<dynamic>? bookmarks;
  bool? isActive;
  bool? isLocked;
  int? lastSeen;
  int? createdAt;
  Permissions? permissions;
  List<dynamic>? librariesAccessible;
  List<dynamic>? itemTagsAccessible;

  User({
    this.id,
    this.username,
    this.type,
    this.token,
    this.mediaProgress,
    this.seriesHideFromContinueListening,
    this.bookmarks,
    this.isActive,
    this.isLocked,
    this.lastSeen,
    this.createdAt,
    this.permissions,
    this.librariesAccessible,
    this.itemTagsAccessible,
  });

  @override
  String toString() {
    return 'User(id: $id, username: $username, type: $type, token: $token, mediaProgress: $mediaProgress, seriesHideFromContinueListening: $seriesHideFromContinueListening, bookmarks: $bookmarks, isActive: $isActive, isLocked: $isLocked, lastSeen: $lastSeen, createdAt: $createdAt, permissions: $permissions, librariesAccessible: $librariesAccessible, itemTagsAccessible: $itemTagsAccessible)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as String?,
        username: data['username'] as String?,
        type: data['type'] as String?,
        token: data['token'] as String?,
        mediaProgress: (data['mediaProgress'] as List<dynamic>?)
            ?.map((e) => MediaProgress.fromMap(e as Map<String, dynamic>))
            .toList(),
        seriesHideFromContinueListening:
            data['seriesHideFromContinueListening'] as List<dynamic>?,
        bookmarks: data['bookmarks'] as List<dynamic>?,
        isActive: data['isActive'] as bool?,
        isLocked: data['isLocked'] as bool?,
        lastSeen: data['lastSeen'] as int?,
        createdAt: data['createdAt'] as int?,
        permissions: data['permissions'] == null
            ? null
            : Permissions.fromMap(data['permissions'] as Map<String, dynamic>),
        librariesAccessible: data['librariesAccessible'] as List<dynamic>?,
        itemTagsAccessible: data['itemTagsAccessible'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'type': type,
        'token': token,
        'mediaProgress': mediaProgress?.map((e) => e.toMap()).toList(),
        'seriesHideFromContinueListening': seriesHideFromContinueListening,
        'bookmarks': bookmarks,
        'isActive': isActive,
        'isLocked': isLocked,
        'lastSeen': lastSeen,
        'createdAt': createdAt,
        'permissions': permissions?.toMap(),
        'librariesAccessible': librariesAccessible,
        'itemTagsAccessible': itemTagsAccessible,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());

  factory User.empty() {
    return User(
      id: "",
      username: "",
      type: "",
      token: "",
      mediaProgress: [],
      seriesHideFromContinueListening: [],
      bookmarks: [],
      isActive: false,
      isLocked: false,
      lastSeen: 0,
      createdAt: 0,
      permissions: Permissions.empty(),
      librariesAccessible: [],
      itemTagsAccessible: [],
    );
  }
}
