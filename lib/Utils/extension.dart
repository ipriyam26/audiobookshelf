import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Utils/filter.dart';

extension SortAuthorItemExtension on SortAuthorItem {
  String get query {
    switch (this) {
      case SortAuthorItem.addedAt:
        return 'addedAt';
      case SortAuthorItem.name:
        return 'name';
      case SortAuthorItem.numOfBooks:
        return 'numBooks';
      default:
        return 'addedAt';
    }
  }

  String get label {
    switch (this) {
      case SortAuthorItem.addedAt:
        return 'Added At';
      case SortAuthorItem.name:
        return 'Name';
      case SortAuthorItem.numOfBooks:
        return 'Number of Books';
      default:
        return 'Added At';
    }
  }
}

extension SortSeriesItemExtension on SortSeriesItem {
  String get query {
    switch (this) {
      case SortSeriesItem.numOfBooks:
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
      case SortSeriesItem.numOfBooks:
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

extension ListExtension<T> on List<T> {
  List<T> clamp(int size) {
    if (length > size) {
      return sublist(0, size);
    }
    return this;
  }
}

extension AuthorSorting on List<Author> {
  // define sorting for author

  sortBy(SortAuthorItem criteria) {
    sort((b, a) {
      switch (criteria) {
        case SortAuthorItem.name:
          return a.name.compareTo(b.name);
        case SortAuthorItem.addedAt:
          return a.addedAt.compareTo(b.addedAt);
        case SortAuthorItem.numOfBooks:
          return (a.numBooks ?? 0).compareTo(b.numBooks ?? 0);
        default:
          return a.addedAt.compareTo(b.addedAt);
      }
    });
  }
}
