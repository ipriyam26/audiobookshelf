import 'dart:convert';

import 'package:collection/collection.dart';

class MetaTags {
  String? tagAlbum;
  String? tagArtist;
  String? tagGenre;
  String? tagTitle;
  String? tagTrack;
  String? tagAlbumArtist;
  String? tagComposer;

  MetaTags({
    this.tagAlbum,
    this.tagArtist,
    this.tagGenre,
    this.tagTitle,
    this.tagTrack,
    this.tagAlbumArtist,
    this.tagComposer,
  });

  @override
  String toString() {
    return 'MetaTags(tagAlbum: $tagAlbum, tagArtist: $tagArtist, tagGenre: $tagGenre, tagTitle: $tagTitle, tagTrack: $tagTrack, tagAlbumArtist: $tagAlbumArtist, tagComposer: $tagComposer)';
  }

  factory MetaTags.fromMap(Map<String, dynamic> data) => MetaTags(
        tagAlbum: data['tagAlbum'] as String?,
        tagArtist: data['tagArtist'] as String?,
        tagGenre: data['tagGenre'] as String?,
        tagTitle: data['tagTitle'] as String?,
        tagTrack: data['tagTrack'] as String?,
        tagAlbumArtist: data['tagAlbumArtist'] as String?,
        tagComposer: data['tagComposer'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'tagAlbum': tagAlbum,
        'tagArtist': tagArtist,
        'tagGenre': tagGenre,
        'tagTitle': tagTitle,
        'tagTrack': tagTrack,
        'tagAlbumArtist': tagAlbumArtist,
        'tagComposer': tagComposer,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MetaTags].
  factory MetaTags.fromJson(String data) {
    return MetaTags.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MetaTags] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MetaTags) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      tagAlbum.hashCode ^
      tagArtist.hashCode ^
      tagGenre.hashCode ^
      tagTitle.hashCode ^
      tagTrack.hashCode ^
      tagAlbumArtist.hashCode ^
      tagComposer.hashCode;
}
