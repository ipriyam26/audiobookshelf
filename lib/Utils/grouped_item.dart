import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:audiobookshelf/Utils/book_stack.dart';
import 'package:audiobookshelf/View/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GroupedItemView extends StatelessWidget {
  GroupedItemView({
    super.key,
    required this.item,
    required this.displayAuthor,
  });

  final GroupedItems item;
  final HomeController homeController = Get.find();
  final bool displayAuthor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => GroupedView(item: item),
          transition: Transition.cupertino,
        );
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.primary.withOpacity(0.1),
              blurRadius: 8.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        height: displayAuthor ? 200.h : 180.h,
        width: 320.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (item.books.isNotEmpty)
              BookStack(
                  images: item.books
                      .map((book) => homeController.getCoverUrl(book.id))
                      .toList()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: Get.theme.textTheme.titleLarge!
                      .copyWith(fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (displayAuthor)
                  Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        item.authorName,
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: Get.theme.colorScheme.outline),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
