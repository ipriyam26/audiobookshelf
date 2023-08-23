import 'dart:convert';

import 'package:collection/collection.dart';

class Settings {
  int? coverAspectRatio;
  bool? disableWatcher;
  bool? skipMatchingMediaWithAsin;
  bool? skipMatchingMediaWithIsbn;
  dynamic autoScanCronExpression;

  Settings({
    this.coverAspectRatio,
    this.disableWatcher,
    this.skipMatchingMediaWithAsin,
    this.skipMatchingMediaWithIsbn,
    this.autoScanCronExpression,
  });

  @override
  String toString() {
    return 'Settings(coverAspectRatio: $coverAspectRatio, disableWatcher: $disableWatcher, skipMatchingMediaWithAsin: $skipMatchingMediaWithAsin, skipMatchingMediaWithIsbn: $skipMatchingMediaWithIsbn, autoScanCronExpression: $autoScanCronExpression)';
  }

  factory Settings.fromMap(Map<String, dynamic> data) => Settings(
        coverAspectRatio: data['coverAspectRatio'] as int?,
        disableWatcher: data['disableWatcher'] as bool?,
        skipMatchingMediaWithAsin: data['skipMatchingMediaWithAsin'] as bool?,
        skipMatchingMediaWithIsbn: data['skipMatchingMediaWithIsbn'] as bool?,
        autoScanCronExpression: data['autoScanCronExpression'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'coverAspectRatio': coverAspectRatio,
        'disableWatcher': disableWatcher,
        'skipMatchingMediaWithAsin': skipMatchingMediaWithAsin,
        'skipMatchingMediaWithIsbn': skipMatchingMediaWithIsbn,
        'autoScanCronExpression': autoScanCronExpression,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Settings].
  factory Settings.fromJson(String data) {
    return Settings.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Settings] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Settings) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      coverAspectRatio.hashCode ^
      disableWatcher.hashCode ^
      skipMatchingMediaWithAsin.hashCode ^
      skipMatchingMediaWithIsbn.hashCode ^
      autoScanCronExpression.hashCode;
}
