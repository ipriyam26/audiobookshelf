import 'dart:convert';

import 'package:collection/collection.dart';

import 'library_item.dart';

class LibraryItemsResponse {
  List<LibraryItem>? libraryItems;

  LibraryItemsResponse({this.libraryItems});

  @override
  String toString() => 'LibraryItemsResponse(libraryItems: $libraryItems)';

  factory LibraryItemsResponse.fromMap(Map<String, dynamic> data) {
    return LibraryItemsResponse(
      libraryItems: (data['libraryItems'] as List<dynamic>?)
          ?.map((e) => LibraryItem.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'libraryItems': libraryItems?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LibraryItemsResponse].
  factory LibraryItemsResponse.fromJson(String data) {
    return LibraryItemsResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LibraryItemsResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LibraryItemsResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => libraryItems.hashCode;
}
