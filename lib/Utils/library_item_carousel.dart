import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/library_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryItemCarousel extends StatelessWidget {
  const LibraryItemCarousel({
    super.key,
    required this.items,
    this.showProgress = false,
    this.displayAuthor = true,
    this.gridView = false,
  });
  final bool gridView;

  final List<LibraryItem> items;
  final bool showProgress;
  final bool displayAuthor;
  @override
  Widget build(BuildContext context) {
    return gridView
        ? Wrap(
            children: items
                .map((LibraryItem item) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      child: LibraryItemCard(
                        item: item,
                        showProgress: showProgress,
                        displayAuthor: displayAuthor,
                      ),
                    ))
                .toList())
        : SizedBox(
            height: displayAuthor ? 184.h : 170.h,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: LibraryItemCard(
                    item: items[index],
                    showProgress: showProgress,
                    displayAuthor: displayAuthor,
                  ),
                );
              },
            ),
          );
  }
}
