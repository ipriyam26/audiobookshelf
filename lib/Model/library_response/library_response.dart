import 'dart:convert';

import 'package:collection/collection.dart';

import 'library.dart';

class LibraryResponse {
  List<Library>? libraries;

  LibraryResponse({this.libraries});

  @override
  String toString() => 'LibraryResponse(libraries: $libraries)';

  factory LibraryResponse.fromMap(Map<String, dynamic> data) {
    return LibraryResponse(
      libraries: (data['libraries'] as List<dynamic>?)
          ?.map((e) => Library.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'libraries': libraries?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LibraryResponse].
  factory LibraryResponse.fromJson(String data) {
    return LibraryResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LibraryResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LibraryResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => libraries.hashCode;
}
