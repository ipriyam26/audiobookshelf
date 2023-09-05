import 'dart:convert';

import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:collection/collection.dart';

import 'book.dart';

class SearchResponse {
  final List<Book> book;
  final List<dynamic> tags;
  final List<Author> authors;
  final List<dynamic> series;

  SearchResponse(
      {required this.book,
      required this.tags,
      required this.authors,
      required this.series});

  @override
  String toString() {
    return 'SearchResponse(book: $book,\n tags: $tags,\n authors: $authors,\n series: $series)';
  }
factory SearchResponse.empty(){
  return SearchResponse(
    book: [],
    tags: [],
    authors: [],
    series: [],
  );
}
  factory SearchResponse.fromMap(Map<String, dynamic> data) {
    return SearchResponse(
      book: ((data['book'] as List<dynamic>?) ?? [])
          .map((e) => Book.fromMap(e as Map<String, dynamic>))
          .toList(),
      tags: ((data['tags'] as List<dynamic>?) ?? [])
          .map((e) => e as dynamic)
          .toList(),
      authors: ((data['authors'] as List<dynamic>?) ?? [])
          .map((e) => Author.fromMap(e as Map<String, dynamic>))
          .toList(),
      series: (data['series'] as List<dynamic>?) ?? [],
    );
  }

  Map<String, dynamic> toMap() => {
        'book': book.map((e) => e.toMap()).toList(),
        'tags': tags,
        'authors': authors.map((e) => e.toMap()).toList(),
        'series': series,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchResponse].
  factory SearchResponse.fromJson(String data) {
    return SearchResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SearchResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  SearchResponse copyWith({
    List<Book>? book,
    List<String>? tags,
    List<Author>? authors,
    List<dynamic>? series,
  }) {
    return SearchResponse(
      book: book ?? this.book,
      tags: tags ?? this.tags,
      authors: authors ?? this.authors,
      series: series ?? this.series,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SearchResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      book.hashCode ^ tags.hashCode ^ authors.hashCode ^ series.hashCode;
}
