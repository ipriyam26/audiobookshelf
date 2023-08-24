import 'dart:convert';

import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:collection/collection.dart';

class LibraryItemsResult {
  List<LibraryItem>? results;
  int? total;
  int? limit;
  int? page;
  String? sortBy;
  bool? sortDesc;
  String? filterBy;
  String? mediaType;
  bool? minified;
  bool? collapseseries;
  String? include;

  LibraryItemsResult({
    this.results,
    this.total,
    this.limit,
    this.page,
    this.sortBy,
    this.sortDesc,
    this.filterBy,
    this.mediaType,
    this.minified,
    this.collapseseries,
    this.include,
  });

  @override
  String toString() {
    return 'LibraryItemsResult(results: $results, total: $total, limit: $limit, page: $page, sortBy: $sortBy, sortDesc: $sortDesc, filterBy: $filterBy, mediaType: $mediaType, minified: $minified, collapseseries: $collapseseries, include: $include)';
  }

  factory LibraryItemsResult.fromMap(Map<String, dynamic> data) {
    return LibraryItemsResult(
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => LibraryItem.fromMap(e as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int?,
      limit: data['limit'] as int?,
      page: data['page'] as int?,
      sortBy: data['sortBy'] as String?,
      sortDesc: data['sortDesc'] as bool?,
      filterBy: data['filterBy'] as String?,
      mediaType: data['mediaType'] as String?,
      minified: data['minified'] as bool?,
      collapseseries: data['collapseseries'] as bool?,
      include: data['include'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'results': results?.map((e) => e.toMap()).toList(),
        'total': total,
        'limit': limit,
        'page': page,
        'sortBy': sortBy,
        'sortDesc': sortDesc,
        'filterBy': filterBy,
        'mediaType': mediaType,
        'minified': minified,
        'collapseseries': collapseseries,
        'include': include,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LibraryItemsResult].
  factory LibraryItemsResult.fromJson(String data) {
    return LibraryItemsResult.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LibraryItemsResult] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LibraryItemsResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      results.hashCode ^
      total.hashCode ^
      limit.hashCode ^
      page.hashCode ^
      sortBy.hashCode ^
      sortDesc.hashCode ^
      filterBy.hashCode ^
      mediaType.hashCode ^
      minified.hashCode ^
      collapseseries.hashCode ^
      include.hashCode;
}
