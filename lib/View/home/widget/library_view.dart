import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/library_item_carousel.dart';

import 'package:audiobookshelf/View/home/widget/recent_authors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LibraryView<T> extends StatelessWidget {
  const LibraryView({
    super.key,
    required this.items,
    required this.title,
    required this.isGridView,
  });

  final List<T> items;

  final String title;
  final RxBool isGridView;

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: Get.theme.textTheme.titleLarge),
                        IconButton(
                            onPressed: () {
                              isGridView.value = !isGridView.value;
                            },
                            icon: Obx(() =>
                                IconAnimation(condition: isGridView.value)))
                      ],
                    ),
                  ),
                  Obx(() => ListToGridAnimation(
                        child: isGridView.value
                            ? FindCarouselGridView(
                                key: UniqueKey(), items: items)
                            : FindCarouselListView(
                                key: UniqueKey(), items: items),
                      )),
                ],
              ),
            ],
          );
  }
}

class FindCarouselGridView<T> extends StatelessWidget {
  const FindCarouselGridView({
    super.key,
    required this.items,
  });
  final List<T> items;
  @override
  Widget build(BuildContext context) {
    return items is List<LibraryItem>
        ? LibraryItemCarousel(
            key: UniqueKey(),
            items: items as List<LibraryItem>,
            displayAuthor: true,
            showProgress: true,
            gridView: true,
          )
        : AuthorItemCarousel(
            key: UniqueKey(),
            items: items as List<Author>,
            gridView: true,
          );
  }
}

class FindCarouselListView<T> extends StatelessWidget {
  const FindCarouselListView({
    super.key,
    required this.items,
  });
  final List<T> items;
  @override
  Widget build(BuildContext context) {
    return items is List<LibraryItem>
        ? LibraryItemCarousel(
            key: UniqueKey(),
            items: items as List<LibraryItem>,
            displayAuthor: true,
            showProgress: true,
            gridView: false,
          )
        : AuthorItemCarousel(
            key: UniqueKey(),
            items: items as List<Author>,
            gridView: false,
          );
  }
}
