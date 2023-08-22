import 'dart:convert';

class Permissions {
  bool? download;
  bool? update;
  bool? delete;
  bool? upload;
  bool? accessAllLibraries;
  bool? accessAllTags;
  bool? accessExplicitContent;

  Permissions({
    this.download,
    this.update,
    this.delete,
    this.upload,
    this.accessAllLibraries,
    this.accessAllTags,
    this.accessExplicitContent,
  });

  @override
  String toString() {
    return 'Permissions(download: $download, update: $update, delete: $delete, upload: $upload, accessAllLibraries: $accessAllLibraries, accessAllTags: $accessAllTags, accessExplicitContent: $accessExplicitContent)';
  }

  factory Permissions.fromMap(Map<String, dynamic> data) => Permissions(
        download: data['download'] as bool?,
        update: data['update'] as bool?,
        delete: data['delete'] as bool?,
        upload: data['upload'] as bool?,
        accessAllLibraries: data['accessAllLibraries'] as bool?,
        accessAllTags: data['accessAllTags'] as bool?,
        accessExplicitContent: data['accessExplicitContent'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'download': download,
        'update': update,
        'delete': delete,
        'upload': upload,
        'accessAllLibraries': accessAllLibraries,
        'accessAllTags': accessAllTags,
        'accessExplicitContent': accessExplicitContent,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Permissions].
  factory Permissions.fromJson(String data) {
    return Permissions.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Permissions] to a JSON string.
  String toJson() => json.encode(toMap());
}
