import 'package:audiobookshelf/Controller/booktab_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/View/home/widget/library_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookTab extends StatelessWidget {
  BookTab({super.key});
  final BookTabController bookTabController = Get.put(BookTabController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, LibraryItem>(
      pagingController: bookTabController.pagingController,
      builderDelegate: PagedChildBuilderDelegate<LibraryItem>(
          itemBuilder: (context, item, index) {
        String imageUrl = bookTabController.getCoverUrl(item);
        // print(item.media.duration);
        return LibraryItemListView(item: item, imageUrl: imageUrl);
      }),
    );
  }
}
