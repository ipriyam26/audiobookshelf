import 'package:audiobookshelf/Controller/booktab_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/extension.dart';
import 'package:audiobookshelf/Utils/filter.dart';
import 'package:audiobookshelf/Utils/library_card_item.dart';
import 'package:audiobookshelf/View/home/widget/library_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookTab extends StatelessWidget {
  BookTab({super.key});
  final BookTabController bookTabController = Get.put(BookTabController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          const TabTitle(),
          Expanded(
            flex: 1,
            child: Obx(() => ListToGridAnimation(
                  child: bookTabController.isGridView.value
                      ? GridViewTab()
                      : ListViewTab(),
                )),
          )
        ],
      ),
    );
  }
}

class ListViewTab extends StatelessWidget {
  ListViewTab({
    super.key,
  });

  final BookTabController bookTabController = Get.find<BookTabController>();

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, LibraryItem>(
      pagingController: bookTabController.pagingController,
      builderDelegate: PagedChildBuilderDelegate<LibraryItem>(
          itemBuilder: (context, item, index) {
        String imageUrl = bookTabController.getCoverUrl(item);
        return LibraryItemListView(item: item, imageUrl: imageUrl);
      }),
    );
  }
}

class GridViewTab extends StatelessWidget {
  GridViewTab({
    super.key,
  });

  final BookTabController bookTabController = Get.find<BookTabController>();

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      pagingController: bookTabController.pagingController,
      builderDelegate: PagedChildBuilderDelegate<LibraryItem>(
          itemBuilder: (context, item, index) {
        return LibraryItemCard(
            showProgress: false, item: item, displayAuthor: true);
      }),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 28.w,
          childAspectRatio: 0.8,
          maxCrossAxisExtent: 174.w),
    );
  }
}

class TabTitle extends StatelessWidget {
  const TabTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Books",
            style: Get.textTheme.titleLarge,
          ),
          FilterItems(),
        ],
      ),
    );
  }
}

class FilterItems extends StatelessWidget {
  FilterItems({
    super.key,
  });

  final BookTabController bookTabController = Get.find<BookTabController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              bookTabController.updateOrderAndRefresh();
            },
            icon: Obx(
              () => bookTabController.desc.value
                  ? const Icon(Icons.keyboard_arrow_down)
                  : const Icon(Icons.keyboard_arrow_up_sharp),
            )),
        Stack(
          children: [
            PopupMenuButton<SortLibraryItem>(
              icon: const Icon(Icons.sort),
              onSelected: (SortLibraryItem result) {
                bookTabController.updateSortAndRefresh(result);
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<SortLibraryItem>>[
                ...SortLibraryItem.values
                    .map(
                      (filter) => PopupMenuItem<SortLibraryItem>(
                        value: filter,
                        child: Text(filter.label),
                      ),
                    )
                    .toList(),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Obx(() => Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Get.theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                        bookTabController.sort.value.label
                            .split("")[0]
                            .toUpperCase(),
                        style: Get.textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                  )),
            )
          ],
        ),
        Obx(() => IconButton(
            onPressed: () {
              bookTabController.isGridView.value =
                  !bookTabController.isGridView.value;
            },
            icon:
                IconAnimation(condition: bookTabController.isGridView.value))),
      ],
    );
  }
}
