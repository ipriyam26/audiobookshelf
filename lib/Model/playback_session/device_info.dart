import 'dart:convert';

import 'package:collection/collection.dart';

class DeviceInfo {
  String? deviceId;
  String? ipAddress;
  String? clientVersion;
  String? serverVersion;

  DeviceInfo({
    this.deviceId,
    this.ipAddress,
    this.clientVersion,
    this.serverVersion,
  });

  @override
  String toString() {
    return 'DeviceInfo(deviceId: $deviceId, ipAddress: $ipAddress, clientVersion: $clientVersion, serverVersion: $serverVersion)';
  }

  factory DeviceInfo.fromMap(Map<String, dynamic> data) => DeviceInfo(
        deviceId: data['deviceId'] as String?,
        ipAddress: data['ipAddress'] as String?,
        clientVersion: data['clientVersion'] as String?,
        serverVersion: data['serverVersion'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'deviceId': deviceId,
        'ipAddress': ipAddress,
        'clientVersion': clientVersion,
        'serverVersion': serverVersion,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DeviceInfo].
  factory DeviceInfo.fromJson(String data) {
    return DeviceInfo.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DeviceInfo] to a JSON string.
  String toJson() => json.encode(toMap());

  DeviceInfo copyWith({
    String? deviceId,
    String? ipAddress,
    String? clientVersion,
    String? serverVersion,
  }) {
    return DeviceInfo(
      deviceId: deviceId ?? this.deviceId,
      ipAddress: ipAddress ?? this.ipAddress,
      clientVersion: clientVersion ?? this.clientVersion,
      serverVersion: serverVersion ?? this.serverVersion,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DeviceInfo) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      deviceId.hashCode ^
      ipAddress.hashCode ^
      clientVersion.hashCode ^
      serverVersion.hashCode;
}
