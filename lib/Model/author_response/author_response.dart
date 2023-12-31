import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:collection/collection.dart';

class Author {
  String id;
  dynamic asin;
  String name;
  dynamic description;
  dynamic imagePath;
  int addedAt;
  int updatedAt;
  List<LibraryItem> libraryItems;
  List<Series> series;
  int? numBooks;

  Author({
    required this.id,
    this.numBooks,
    this.asin,
    required this.name,
    this.description,
    this.imagePath,
    required this.addedAt,
    required this.updatedAt,
    required this.libraryItems,
    required this.series,
  });

  @override
  String toString() {
    return 'AuthorResponse(id: $id, asin: $asin, name: $name, description: $description, imagePath: $imagePath, addedAt: $addedAt, updatedAt: $updatedAt, libraryItems: $libraryItems)';
  }

  factory Author.empty() {
    return Author(
        id: "",
        name: '',
        addedAt: 0,
        updatedAt: 0,
        series: [],
        libraryItems: []);
  }
  factory Author.fromMap(Map<String, dynamic> data) {
    return Author(
      id: data['id'] as String,
      asin: data['asin'] as dynamic,
      name: data['name'] as String,
      description: data['description'] as dynamic,
      imagePath: data['imagePath'] as dynamic,
      addedAt: data['addedAt'] as int,
      updatedAt: data['updatedAt'] as int,
      numBooks: data['numBooks'] as int?,
      libraryItems: ((data['libraryItems'] as List<dynamic>?) ?? [])
          .map((e) => LibraryItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      series: ((data['series'] as List<dynamic>?) ?? [])
          .map((e) => Series.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'asin': asin,
        'name': name,
        'description': description,
        'imagePath': imagePath,
        'addedAt': addedAt,
        'updatedAt': updatedAt,
        'libraryItems': libraryItems.map((e) => e.toMap()).toList(),
        'series': series.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Author].
  factory Author.fromJson(String data) {
    return Author.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Author] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Author) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      asin.hashCode ^
      name.hashCode ^
      description.hashCode ^
      imagePath.hashCode ^
      addedAt.hashCode ^
      updatedAt.hashCode ^
      libraryItems.hashCode;
  String get authorName => name;
  int get bookCount => numBooks ?? libraryItems.length;
  String getAuthorUrl(String server, String token) {
    return "$server/api/authors/$id/image";
  }
}
