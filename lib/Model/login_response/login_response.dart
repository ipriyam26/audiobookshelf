import 'dart:convert';

import 'server_settings.dart';
import 'user.dart';

class LoginResponse {
  User? user;
  String? userDefaultLibraryId;
  ServerSettings? serverSettings;
  String? source;

  LoginResponse({
    this.user,
    this.userDefaultLibraryId,
    this.serverSettings,
    this.source,
  });

  @override
  String toString() {
    return 'LoginResponse(user: $user, userDefaultLibraryId: $userDefaultLibraryId, serverSettings: $serverSettings, source: $source)';
  }

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        userDefaultLibraryId: data['userDefaultLibraryId'] as String?,
        serverSettings: data['serverSettings'] == null
            ? null
            : ServerSettings.fromMap(
                data['serverSettings'] as Map<String, dynamic>),
        source: data['Source'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'user': user?.toMap(),
        'userDefaultLibraryId': userDefaultLibraryId,
        'serverSettings': serverSettings?.toMap(),
        'Source': source,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
