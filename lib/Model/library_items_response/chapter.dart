import 'dart:convert';

import 'package:collection/collection.dart';

class Chapter {
  int? id;
  double? start;
  double? end;
  String? title;

  Chapter({this.id, this.start, this.end, this.title});

  @override
  String toString() {
    return 'Chapter(id: $id, start: $start, end: $end, title: $title)';
  }

  factory Chapter.fromMap(Map<String, dynamic> data) => Chapter(
        id: data['id'] as int?,
        start: (data['start'] as num?)?.toDouble(),
        end: (data['end'] as num?)?.toDouble(),
        title: data['title'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'start': start,
        'end': end,
        'title': title,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Chapter].
  factory Chapter.fromJson(String data) {
    return Chapter.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Chapter] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Chapter) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^ start.hashCode ^ end.hashCode ^ title.hashCode;
}
