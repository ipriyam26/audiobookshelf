import 'dart:convert';

import 'package:collection/collection.dart';

class Series {
  String? id;
  String? name;
  String? sequence;

  Series({this.id, this.name, this.sequence});

  @override
  String toString() => 'Series(id: $id, name: $name, sequence: $sequence)';

  factory Series.fromMap(Map<String, dynamic> data) => Series(
        id: data['id'] as String?,
        name: data['name'] as String?,
        sequence: data['sequence'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'sequence': sequence,
      };

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
  int get hashCode => id.hashCode ^ name.hashCode ^ sequence.hashCode;
}
