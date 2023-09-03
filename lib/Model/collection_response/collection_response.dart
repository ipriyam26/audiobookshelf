import 'dart:convert';

import 'package:collection/collection.dart';

import 'collection.dart';

class CollectionResponse {
  List<Collection> results;
  int? total;
  int? limit;
  int? page;
  bool? sortDesc;
  bool? minified;
  String? include;

  CollectionResponse({
    required this.results,
    this.total,
    this.limit,
    this.page,
    this.sortDesc,
    this.minified,
    this.include,
  });

  @override
  String toString() {
    return 'CollectionResponse(results: $results, total: $total, limit: $limit, page: $page, sortDesc: $sortDesc, minified: $minified, include: $include)';
  }

  factory CollectionResponse.fromMap(Map<String, dynamic> data) {
    return CollectionResponse(
      results: (data['results'] as List<dynamic>?)
              ?.map((e) => Collection.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      total: data['total'] as int?,
      limit: data['limit'] as int?,
      page: data['page'] as int?,
      sortDesc: data['sortDesc'] as bool?,
      minified: data['minified'] as bool?,
      include: data['include'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'results': results.map((e) => e.toMap()).toList(),
        'total': total,
        'limit': limit,
        'page': page,
        'sortDesc': sortDesc,
        'minified': minified,
        'include': include,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CollectionResponse].
  factory CollectionResponse.fromJson(String data) {
    return CollectionResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CollectionResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  CollectionResponse copyWith({
    List<Collection>? results,
    int? total,
    int? limit,
    int? page,
    bool? sortDesc,
    bool? minified,
    String? include,
  }) {
    return CollectionResponse(
      results: results ?? this.results,
      total: total ?? this.total,
      limit: limit ?? this.limit,
      page: page ?? this.page,
      sortDesc: sortDesc ?? this.sortDesc,
      minified: minified ?? this.minified,
      include: include ?? this.include,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CollectionResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      results.hashCode ^
      total.hashCode ^
      limit.hashCode ^
      page.hashCode ^
      sortDesc.hashCode ^
      minified.hashCode ^
      include.hashCode;
}
