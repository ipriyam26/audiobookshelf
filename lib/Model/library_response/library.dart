import 'dart:convert';

import 'package:collection/collection.dart';

import 'folder.dart';
import 'settings.dart';

class Library {
  String? id;
  String? name;
  List<Folder>? folders;
  int? displayOrder;
  String? icon;
  String? mediaType;
  String? provider;
  Settings? settings;
  int? createdAt;
  int? lastUpdate;

  Library({
    this.id,
    this.name,
    this.folders,
    this.displayOrder,
    this.icon,
    this.mediaType,
    this.provider,
    this.settings,
    this.createdAt,
    this.lastUpdate,
  });

  @override
  String toString() {
    return 'Library(id: $id, name: $name, folders: $folders, displayOrder: $displayOrder, icon: $icon, mediaType: $mediaType, provider: $provider, settings: $settings, createdAt: $createdAt, lastUpdate: $lastUpdate)';
  }

  factory Library.fromMap(Map<String, dynamic> data) => Library(
        id: data['id'] as String?,
        name: data['name'] as String?,
        folders: (data['folders'] as List<dynamic>?)
            ?.map((e) => Folder.fromMap(e as Map<String, dynamic>))
            .toList(),
        displayOrder: data['displayOrder'] as int?,
        icon: data['icon'] as String?,
        mediaType: data['mediaType'] as String?,
        provider: data['provider'] as String?,
        settings: data['settings'] == null
            ? null
            : Settings.fromMap(data['settings'] as Map<String, dynamic>),
        createdAt: data['createdAt'] as int?,
        lastUpdate: data['lastUpdate'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'folders': folders?.map((e) => e.toMap()).toList(),
        'displayOrder': displayOrder,
        'icon': icon,
        'mediaType': mediaType,
        'provider': provider,
        'settings': settings?.toMap(),
        'createdAt': createdAt,
        'lastUpdate': lastUpdate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Library].
  factory Library.fromJson(String data) {
    return Library.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Library] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Library) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      folders.hashCode ^
      displayOrder.hashCode ^
      icon.hashCode ^
      mediaType.hashCode ^
      provider.hashCode ^
      settings.hashCode ^
      createdAt.hashCode ^
      lastUpdate.hashCode;
}
