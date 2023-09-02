import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:collection/collection.dart';

class Series {
  String? id;
  String? name;
  String? nameIgnorePrefix;
  String? nameIgnorePrefixSort;
  String? type;
  List<LibraryItem> books;
  int? addedAt;
  double? totalDuration;

  Series({
    this.id,
    this.name,
    this.nameIgnorePrefix,
    this.nameIgnorePrefixSort,
    this.type,
    required this.books,
    this.addedAt,
    this.totalDuration,
  });

  @override
  String toString() {
    return 'Result(id: $id, name: $name, nameIgnorePrefix: $nameIgnorePrefix, nameIgnorePrefixSort: $nameIgnorePrefixSort, type: $type, books: $books, addedAt: $addedAt, totalDuration: $totalDuration)';
  }

  factory Series.fromMap(Map<String, dynamic> data) => Series(
        id: data['id'] as String?,
        name: data['name'] as String?,
        nameIgnorePrefix: data['nameIgnorePrefix'] as String?,
        nameIgnorePrefixSort: data['nameIgnorePrefixSort'] as String?,
        type: data['type'] as String?,
        books: ((data['books'] as List<dynamic>?) ?? [])
            .map((e) => LibraryItem.fromMap(e as Map<String, dynamic>))
            .toList(),
        addedAt: data['addedAt'] as int?,
        totalDuration: (data['totalDuration'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'nameIgnorePrefix': nameIgnorePrefix,
        'nameIgnorePrefixSort': nameIgnorePrefixSort,
        'type': type,
        'books': books.map((e) => e.toMap()).toList(),
        'addedAt': addedAt,
        'totalDuration': totalDuration,
      };
//make a copy with method
  Series copyWith({
    String? id,
    String? name,
    String? nameIgnorePrefix,
    String? nameIgnorePrefixSort,
    String? type,
    List<LibraryItem>? books,
    int? addedAt,
    double? totalDuration,
  }) {
    return Series(
      id: id ?? this.id,
      name: name ?? this.name,
      nameIgnorePrefix: nameIgnorePrefix ?? this.nameIgnorePrefix,
      nameIgnorePrefixSort: nameIgnorePrefixSort ?? this.nameIgnorePrefixSort,
      type: type ?? this.type,
      books: books ?? this.books,
      addedAt: addedAt ?? this.addedAt,
      totalDuration: totalDuration ?? this.totalDuration,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Series].
  factory Series.fromJson(String data) {
    return Series.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Series] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Series) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      nameIgnorePrefix.hashCode ^
      nameIgnorePrefixSort.hashCode ^
      type.hashCode ^
      books.hashCode ^
      addedAt.hashCode ^
      totalDuration.hashCode;

  String get nameCount => "$name (${(books).length})";
  String get authorName => books.first.authorName;
  String get title => name ?? "";
}
