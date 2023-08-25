import 'dart:convert';

import 'package:collection/collection.dart';

import 'series.dart';

class RecentSeriesResponse {
  List<Series>? results;
  int? total;
  int? limit;
  int? page;
  String? sortBy;
  bool? sortDesc;
  bool? minified;
  String? include;

  RecentSeriesResponse({
    this.results,
    this.total,
    this.limit,
    this.page,
    this.sortBy,
    this.sortDesc,
    this.minified,
    this.include,
  });

  @override
  String toString() {
    return 'RecentSeriesResponse(results: $results, total: $total, limit: $limit, page: $page, sortBy: $sortBy, sortDesc: $sortDesc, minified: $minified, include: $include)';
  }

  factory RecentSeriesResponse.fromMap(Map<String, dynamic> data) {
    return RecentSeriesResponse(
      results: (data['results'] as List<dynamic>?)
          ?.map((e) => Series.fromMap(e as Map<String, dynamic>))
          .toList(),
      total: data['total'] as int?,
      limit: data['limit'] as int?,
      page: data['page'] as int?,
      sortBy: data['sortBy'] as String?,
      sortDesc: data['sortDesc'] as bool?,
      minified: data['minified'] as bool?,
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
        'minified': minified,
        'include': include,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [RecentSeriesResponse].
  factory RecentSeriesResponse.fromJson(String data) {
    return RecentSeriesResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RecentSeriesResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RecentSeriesResponse) return false;
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
      minified.hashCode ^
      include.hashCode;
}
