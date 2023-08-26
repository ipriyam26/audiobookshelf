import 'dart:convert';

import 'package:collection/collection.dart';

class AuthorMini {
  String? id;
  String? name;

  AuthorMini({this.id, this.name});

  @override
  String toString() => 'Author(id: $id, name: $name)';

  factory AuthorMini.fromMap(Map<String, dynamic> data) => AuthorMini(
        id: data['id'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AuthorMini].
  factory AuthorMini.fromJson(String data) {
    return AuthorMini.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AuthorMini] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AuthorMini) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
