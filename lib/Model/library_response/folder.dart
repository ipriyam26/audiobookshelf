import 'dart:convert';

class Folder {
  String? id;
  String? fullPath;
  String? libraryId;
  Folder({
    this.id,
    this.fullPath,
    this.libraryId,
  });

  factory Folder.fromJson(String data) {
    return Folder.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  factory Folder.fromMap(Map<String, dynamic> data) => Folder(
        id: data['id'] as String?,
        fullPath: data['fullPath'] as String?,
        libraryId: data['libraryId'] as String?,
      );
  Map<String, dynamic> toMap() => {
        'id': id,
        'fullPath': fullPath,
        'libraryId': libraryId,
      };
}
