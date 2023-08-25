import 'dart:convert';

import 'package:collection/collection.dart';

class SeriesMini {
  String? id;
  String? name;
  String? sequence;

  SeriesMini({this.id, this.name, this.sequence});

  @override
  String toString() => 'Series(id: $id, name: $name, sequence: $sequence)';

  factory SeriesMini.fromMap(Map<String, dynamic> data) => SeriesMini(
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
  /// Parses the string and returns the resulting Json object as [SeriesMini].
  factory SeriesMini.fromJson(String data) {
    return SeriesMini.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SeriesMini] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SeriesMini) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ sequence.hashCode;
}
