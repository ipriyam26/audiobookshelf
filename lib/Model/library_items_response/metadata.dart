import 'dart:convert';

import 'package:collection/collection.dart';

import 'author.dart';
import 'series.dart';

class Metadata {
  String? title;
  String? titleIgnorePrefix;
  dynamic subtitle;
  List<Author>? authors;
  List<dynamic>? narrators;
  List<SeriesMini>? series;
  List<dynamic>? genres;
  String? publishedYear;
  dynamic publishedDate;
  String? publisher;
  String? description;
  dynamic isbn;
  String? asin;
  dynamic language;
  bool? explicit;
  String? authorName;
  String? authorNameLf;
  String? narratorName;
  String? seriesName;

  Metadata({
    this.title,
    this.titleIgnorePrefix,
    this.subtitle,
    this.authors,
    this.narrators,
    this.series,
    this.genres,
    this.publishedYear,
    this.publishedDate,
    this.publisher,
    this.description,
    this.isbn,
    this.asin,
    this.language,
    this.explicit,
    this.authorName,
    this.authorNameLf,
    this.narratorName,
    this.seriesName,
  });

  @override
  String toString() {
    return 'Metadata(title: $title, titleIgnorePrefix: $titleIgnorePrefix, subtitle: $subtitle, authors: $authors, narrators: $narrators, series: $series, genres: $genres, publishedYear: $publishedYear, publishedDate: $publishedDate, publisher: $publisher, description: $description, isbn: $isbn, asin: $asin, language: $language, explicit: $explicit, authorName: $authorName, authorNameLf: $authorNameLf, narratorName: $narratorName, seriesName: $seriesName)';
  }

  factory Metadata.fromMap(Map<String, dynamic> data) => Metadata(
        title: data['title'] as String?,
        titleIgnorePrefix: data['titleIgnorePrefix'] as String?,
        subtitle: data['subtitle'] as dynamic,
        authors: (data['authors'] as List<dynamic>?)
            ?.map((e) => Author.fromMap(e as Map<String, dynamic>))
            .toList(),
        narrators: data['narrators'] as List<dynamic>?,
        series: (data['series'] as List<dynamic>?)
            ?.map((e) => SeriesMini.fromMap(e as Map<String, dynamic>))
            .toList(),
        genres: data['genres'] as List<dynamic>?,
        publishedYear: data['publishedYear'] as String?,
        publishedDate: data['publishedDate'] as dynamic,
        publisher: data['publisher'] as String?,
        description: data['description'] as String?,
        isbn: data['isbn'] as dynamic,
        asin: data['asin'] as String?,
        language: data['language'] as dynamic,
        explicit: data['explicit'] as bool?,
        authorName: data['authorName'] as String?,
        authorNameLf: data['authorNameLF'] as String?,
        narratorName: data['narratorName'] as String?,
        seriesName: data['seriesName'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'titleIgnorePrefix': titleIgnorePrefix,
        'subtitle': subtitle,
        'authors': authors?.map((e) => e.toMap()).toList(),
        'narrators': narrators,
        'series': series?.map((e) => e.toMap()).toList(),
        'genres': genres,
        'publishedYear': publishedYear,
        'publishedDate': publishedDate,
        'publisher': publisher,
        'description': description,
        'isbn': isbn,
        'asin': asin,
        'language': language,
        'explicit': explicit,
        'authorName': authorName,
        'authorNameLF': authorNameLf,
        'narratorName': narratorName,
        'seriesName': seriesName,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Metadata].
  factory Metadata.fromJson(String data) {
    return Metadata.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Metadata] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Metadata) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      title.hashCode ^
      titleIgnorePrefix.hashCode ^
      subtitle.hashCode ^
      authors.hashCode ^
      narrators.hashCode ^
      series.hashCode ^
      genres.hashCode ^
      publishedYear.hashCode ^
      publishedDate.hashCode ^
      publisher.hashCode ^
      description.hashCode ^
      isbn.hashCode ^
      asin.hashCode ^
      language.hashCode ^
      explicit.hashCode ^
      authorName.hashCode ^
      authorNameLf.hashCode ^
      narratorName.hashCode ^
      seriesName.hashCode;
}
