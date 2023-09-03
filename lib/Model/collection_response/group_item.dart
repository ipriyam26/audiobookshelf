import 'package:audiobookshelf/Model/library_items_response/library_item.dart';

class GroupedItems {
  String id;
  String name;
  List<LibraryItem> books;

  GroupedItems({
    required this.id,
    required this.name,
    required this.books,
  });
  String get nameCount => "$name (${(books).length})";
  String get authorName => books.first.authorName;
  String get title => name;
}
