import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/login_response/media_progress.dart';

class LibraryItemWithProgress extends LibraryItem {
  @override
  final MediaProgress mediaProgress;

  LibraryItemWithProgress({
    required LibraryItem libraryItem,
    required this.mediaProgress,
  }) : super(
          id: libraryItem.id,
          ino: libraryItem.ino,
          libraryId: libraryItem.libraryId,
          folderId: libraryItem.folderId,
          path: libraryItem.path,
          relPath: libraryItem.relPath,
          isFile: libraryItem.isFile,
          mtimeMs: libraryItem.mtimeMs,
          ctimeMs: libraryItem.ctimeMs,
          birthtimeMs: libraryItem.birthtimeMs,
          addedAt: libraryItem.addedAt,
          updatedAt: libraryItem.updatedAt,
          lastScan: libraryItem.lastScan,
          scanVersion: libraryItem.scanVersion,
          isMissing: libraryItem.isMissing,
          isInvalid: libraryItem.isInvalid,
          mediaType: libraryItem.mediaType,
          media: libraryItem.media,
          libraryFiles: libraryItem.libraryFiles,
          size: libraryItem.size,
        );
}
