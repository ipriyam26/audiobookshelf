import 'dart:convert';

import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:collection/collection.dart';

class Collection extends GroupedItems {
  String? libraryId;
  String? userId;

  dynamic description;

  int? lastUpdate;
  int? createdAt;

  Collection({
    this.libraryId,
    this.userId,
    this.description,
    this.lastUpdate,
    this.createdAt,
    required super.id,
    required super.name,
    required super.books,
  });

  @override
  String toString() {
    return 'Result(id: $id, libraryId: $libraryId, userId: $userId, name: $name, description: $description, books: $books, lastUpdate: $lastUpdate, createdAt: $createdAt)';
  }

  factory Collection.fromMap(Map<String, dynamic> data) => Collection(
        id: data['id'] as String,
        libraryId: data['libraryId'] as String?,
        userId: data['userId'] as String?,
        name: data['name'] as String,
        description: data['description'] as dynamic,
        books: (data['books'] as List<dynamic>?)
                ?.map((e) => LibraryItem.fromMap(e as Map<String, dynamic>))
                .toList() ??
            [],
        lastUpdate: data['lastUpdate'] as int?,
        createdAt: data['createdAt'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'libraryId': libraryId,
        'userId': userId,
        'name': name,
        'description': description,
        'books': books.map((e) => e.toMap()).toList(),
        'lastUpdate': lastUpdate,
        'createdAt': createdAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Collection].
  factory Collection.fromJson(String data) {
    return Collection.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Collection] to a JSON string.
  String toJson() => json.encode(toMap());

  Collection copyWith({
    String? id,
    String? libraryId,
    String? userId,
    String? name,
    dynamic description,
    List<LibraryItem>? books,
    int? lastUpdate,
    int? createdAt,
  }) {
    return Collection(
      id: id ?? this.id,
      libraryId: libraryId ?? this.libraryId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      books: books ?? this.books,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Collection) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      libraryId.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      description.hashCode ^
      books.hashCode ^
      lastUpdate.hashCode ^
      createdAt.hashCode;
}
