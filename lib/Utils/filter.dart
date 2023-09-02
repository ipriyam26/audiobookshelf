enum SortLibraryItem {
  title,
  publishYear,
  authorName,
  updated,
  added,
}

enum SortSeriesItem {
  numOkBooks,
  duration,
  addedAt,
}

extension SortSeriesItemExtension on SortSeriesItem {
  String get query {
    switch (this) {
      case SortSeriesItem.numOkBooks:
        return 'numBooks';
      case SortSeriesItem.duration:
        return 'totalDuration';
      case SortSeriesItem.addedAt:
        return 'addedAt';
      default:
        return 'addedAt';
    }
  }

  String get label {
    switch (this) {
      case SortSeriesItem.numOkBooks:
        return 'Number of Books';
      case SortSeriesItem.duration:
        return 'Total Duration';
      case SortSeriesItem.addedAt:
        return 'Added At';
      default:
        return 'Added At';
    }
  }
}

extension SortLibraryItemExtension on SortLibraryItem {
  String get query {
    switch (this) {
      case SortLibraryItem.title:
        return 'media.metadata.title';
      case SortLibraryItem.publishYear:
        return 'media.metadata.publishedYear';
      case SortLibraryItem.authorName:
        return 'media.metadata.authorName';
      case SortLibraryItem.updated:
        return 'updatedAt';
      case SortLibraryItem.added:
        return 'addedAt';
      default:
        return 'updatedAt';
    }
  }

  String get label {
    switch (this) {
      case SortLibraryItem.title:
        return 'Title';
      case SortLibraryItem.publishYear:
        return 'Publish Year';
      case SortLibraryItem.authorName:
        return 'Author Name';
      case SortLibraryItem.updated:
        return 'Updated';
      case SortLibraryItem.added:
        return 'Added';
      default:
        return '';
    }
  }
}
