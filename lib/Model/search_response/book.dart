import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:collection/collection.dart';

class Book {
  LibraryItem libraryItem;
  String? matchKey;
  String? matchText;

  Book({required this.libraryItem, this.matchKey, this.matchText});

  @override
  String toString() {
    return 'Book(libraryItem: $libraryItem, matchKey: $matchKey, matchText: $matchText)';
  }

  factory Book.fromMap(Map<String, dynamic> data) => Book(
        libraryItem: data['libraryItem'] == null
            ? LibraryItem.empty()
            : LibraryItem.fromMap(data['libraryItem'] as Map<String, dynamic>),
        matchKey: data['matchKey'] as String?,
        matchText: data['matchText'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'libraryItem': libraryItem.toMap(),
        'matchKey': matchKey,
        'matchText': matchText,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Book].
  factory Book.fromJson(String data) {
    return Book.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Book] to a JSON string.
  String toJson() => json.encode(toMap());

  Book copyWith({
    LibraryItem? libraryItem,
    String? matchKey,
    String? matchText,
  }) {
    return Book(
      libraryItem: libraryItem ?? this.libraryItem,
      matchKey: matchKey ?? this.matchKey,
      matchText: matchText ?? this.matchText,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Book) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      libraryItem.hashCode ^ matchKey.hashCode ^ matchText.hashCode;
}
