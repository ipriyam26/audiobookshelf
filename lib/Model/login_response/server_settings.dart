import 'dart:convert';

class ServerSettings {
  String? id;
  bool? scannerFindCovers;
  String? scannerCoverProvider;
  bool? scannerParseSubtitle;
  bool? scannerPreferAudioMetadata;
  bool? scannerPreferOpfMetadata;
  bool? scannerPreferMatchedMetadata;
  bool? scannerDisableWatcher;
  bool? scannerPreferOverdriveMediaMarker;
  bool? scannerUseSingleThreadedProber;
  int? scannerMaxThreads;
  bool? scannerUseTone;
  bool? storeCoverWithItem;
  bool? storeMetadataWithItem;
  String? metadataFileFormat;
  int? rateLimitLoginRequests;
  int? rateLimitLoginWindow;
  String? backupSchedule;
  int? backupsToKeep;
  int? maxBackupSize;
  bool? backupMetadataCovers;
  int? loggerDailyLogsToKeep;
  int? loggerScannerLogsToKeep;
  int? homeBookshelfView;
  int? bookshelfView;
  bool? sortingIgnorePrefix;
  List<dynamic>? sortingPrefixes;
  bool? chromecastEnabled;
  String? dateFormat;
  String? language;
  int? logLevel;
  String? version;

  ServerSettings({
    this.id,
    this.scannerFindCovers,
    this.scannerCoverProvider,
    this.scannerParseSubtitle,
    this.scannerPreferAudioMetadata,
    this.scannerPreferOpfMetadata,
    this.scannerPreferMatchedMetadata,
    this.scannerDisableWatcher,
    this.scannerPreferOverdriveMediaMarker,
    this.scannerUseSingleThreadedProber,
    this.scannerMaxThreads,
    this.scannerUseTone,
    this.storeCoverWithItem,
    this.storeMetadataWithItem,
    this.metadataFileFormat,
    this.rateLimitLoginRequests,
    this.rateLimitLoginWindow,
    this.backupSchedule,
    this.backupsToKeep,
    this.maxBackupSize,
    this.backupMetadataCovers,
    this.loggerDailyLogsToKeep,
    this.loggerScannerLogsToKeep,
    this.homeBookshelfView,
    this.bookshelfView,
    this.sortingIgnorePrefix,
    this.sortingPrefixes,
    this.chromecastEnabled,
    this.dateFormat,
    this.language,
    this.logLevel,
    this.version,
  });

  @override
  String toString() {
    return 'ServerSettings(id: $id, scannerFindCovers: $scannerFindCovers, scannerCoverProvider: $scannerCoverProvider, scannerParseSubtitle: $scannerParseSubtitle, scannerPreferAudioMetadata: $scannerPreferAudioMetadata, scannerPreferOpfMetadata: $scannerPreferOpfMetadata, scannerPreferMatchedMetadata: $scannerPreferMatchedMetadata, scannerDisableWatcher: $scannerDisableWatcher, scannerPreferOverdriveMediaMarker: $scannerPreferOverdriveMediaMarker, scannerUseSingleThreadedProber: $scannerUseSingleThreadedProber, scannerMaxThreads: $scannerMaxThreads, scannerUseTone: $scannerUseTone, storeCoverWithItem: $storeCoverWithItem, storeMetadataWithItem: $storeMetadataWithItem, metadataFileFormat: $metadataFileFormat, rateLimitLoginRequests: $rateLimitLoginRequests, rateLimitLoginWindow: $rateLimitLoginWindow, backupSchedule: $backupSchedule, backupsToKeep: $backupsToKeep, maxBackupSize: $maxBackupSize, backupMetadataCovers: $backupMetadataCovers, loggerDailyLogsToKeep: $loggerDailyLogsToKeep, loggerScannerLogsToKeep: $loggerScannerLogsToKeep, homeBookshelfView: $homeBookshelfView, bookshelfView: $bookshelfView, sortingIgnorePrefix: $sortingIgnorePrefix, sortingPrefixes: $sortingPrefixes, chromecastEnabled: $chromecastEnabled, dateFormat: $dateFormat, language: $language, logLevel: $logLevel, version: $version)';
  }

  factory ServerSettings.fromMap(Map<String, dynamic> data) {
    return ServerSettings(
      id: data['id'] as String?,
      scannerFindCovers: data['scannerFindCovers'] as bool?,
      scannerCoverProvider: data['scannerCoverProvider'] as String?,
      scannerParseSubtitle: data['scannerParseSubtitle'] as bool?,
      scannerPreferAudioMetadata: data['scannerPreferAudioMetadata'] as bool?,
      scannerPreferOpfMetadata: data['scannerPreferOpfMetadata'] as bool?,
      scannerPreferMatchedMetadata:
          data['scannerPreferMatchedMetadata'] as bool?,
      scannerDisableWatcher: data['scannerDisableWatcher'] as bool?,
      scannerPreferOverdriveMediaMarker:
          data['scannerPreferOverdriveMediaMarker'] as bool?,
      scannerUseSingleThreadedProber:
          data['scannerUseSingleThreadedProber'] as bool?,
      scannerMaxThreads: data['scannerMaxThreads'] as int?,
      scannerUseTone: data['scannerUseTone'] as bool?,
      storeCoverWithItem: data['storeCoverWithItem'] as bool?,
      storeMetadataWithItem: data['storeMetadataWithItem'] as bool?,
      metadataFileFormat: data['metadataFileFormat'] as String?,
      rateLimitLoginRequests: data['rateLimitLoginRequests'] as int?,
      rateLimitLoginWindow: data['rateLimitLoginWindow'] as int?,
      backupSchedule: data['backupSchedule'] as String?,
      backupsToKeep: data['backupsToKeep'] as int?,
      maxBackupSize: data['maxBackupSize'] as int?,
      backupMetadataCovers: data['backupMetadataCovers'] as bool?,
      loggerDailyLogsToKeep: data['loggerDailyLogsToKeep'] as int?,
      loggerScannerLogsToKeep: data['loggerScannerLogsToKeep'] as int?,
      homeBookshelfView: data['homeBookshelfView'] as int?,
      bookshelfView: data['bookshelfView'] as int?,
      sortingIgnorePrefix: data['sortingIgnorePrefix'] as bool?,
      sortingPrefixes: data['sortingPrefixes'] as List<dynamic>?,
      chromecastEnabled: data['chromecastEnabled'] as bool?,
      dateFormat: data['dateFormat'] as String?,
      language: data['language'] as String?,
      logLevel: data['logLevel'] as int?,
      version: data['version'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'scannerFindCovers': scannerFindCovers,
        'scannerCoverProvider': scannerCoverProvider,
        'scannerParseSubtitle': scannerParseSubtitle,
        'scannerPreferAudioMetadata': scannerPreferAudioMetadata,
        'scannerPreferOpfMetadata': scannerPreferOpfMetadata,
        'scannerPreferMatchedMetadata': scannerPreferMatchedMetadata,
        'scannerDisableWatcher': scannerDisableWatcher,
        'scannerPreferOverdriveMediaMarker': scannerPreferOverdriveMediaMarker,
        'scannerUseSingleThreadedProber': scannerUseSingleThreadedProber,
        'scannerMaxThreads': scannerMaxThreads,
        'scannerUseTone': scannerUseTone,
        'storeCoverWithItem': storeCoverWithItem,
        'storeMetadataWithItem': storeMetadataWithItem,
        'metadataFileFormat': metadataFileFormat,
        'rateLimitLoginRequests': rateLimitLoginRequests,
        'rateLimitLoginWindow': rateLimitLoginWindow,
        'backupSchedule': backupSchedule,
        'backupsToKeep': backupsToKeep,
        'maxBackupSize': maxBackupSize,
        'backupMetadataCovers': backupMetadataCovers,
        'loggerDailyLogsToKeep': loggerDailyLogsToKeep,
        'loggerScannerLogsToKeep': loggerScannerLogsToKeep,
        'homeBookshelfView': homeBookshelfView,
        'bookshelfView': bookshelfView,
        'sortingIgnorePrefix': sortingIgnorePrefix,
        'sortingPrefixes': sortingPrefixes,
        'chromecastEnabled': chromecastEnabled,
        'dateFormat': dateFormat,
        'language': language,
        'logLevel': logLevel,
        'version': version,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ServerSettings].
  factory ServerSettings.fromJson(String data) {
    return ServerSettings.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  factory ServerSettings.empty() {
    return ServerSettings(
      id: "",
      scannerFindCovers: false,
      scannerCoverProvider: "",
      scannerParseSubtitle: false,
      scannerPreferAudioMetadata: false,
      scannerPreferOpfMetadata: false,
      scannerPreferMatchedMetadata: false,
      scannerDisableWatcher: false,
      scannerPreferOverdriveMediaMarker: false,
      scannerUseSingleThreadedProber: false,
      scannerMaxThreads: 0,
      scannerUseTone: false,
      storeCoverWithItem: false,
      storeMetadataWithItem: false,
      metadataFileFormat: "",
      rateLimitLoginRequests: 0,
      rateLimitLoginWindow: 0,
      backupSchedule: "",
      backupsToKeep: 0,
      maxBackupSize: 0,
      backupMetadataCovers: false,
      loggerDailyLogsToKeep: 0,
      loggerScannerLogsToKeep: 0,
      homeBookshelfView: 0,
      bookshelfView: 0,
      sortingIgnorePrefix: false,
      sortingPrefixes: [],
      chromecastEnabled: false,
      dateFormat: "",
      language: "",
      logLevel: 0,
      version: "",
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ServerSettings] to a JSON string.
  String toJson() => json.encode(toMap());
}
