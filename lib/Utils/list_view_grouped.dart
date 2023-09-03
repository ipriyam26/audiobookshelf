import 'package:audiobookshelf/Controller/grouped_controller.dart';
import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:audiobookshelf/Utils/book_stack.dart';
import 'package:audiobookshelf/View/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListViewGrouped extends StatelessWidget {
  const ListViewGrouped({
    super.key,
    required this.controller,
  });

  final GroupedTabController controller;

  @override
  Widget build(BuildContext context) {
    return PagedListView(
        // shrinkWrap: true,
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<GroupedItems>(
            itemBuilder: (context, item, index) {
          return InkWell(
            onTap: () {
              Get.to(
                () => GroupedView(item: item),
                transition: Transition.cupertino,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(children: [
                    BookStack(
                        scaleFactor: 0.4, images: controller.getCoverUrl(item)),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Get.theme.colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Text(item.books.length.toString(),
                            style: Get.textTheme.labelMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )
                  ]),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 4.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: Get.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "by ${item.authorName}",
                            style: Get.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.onSurfaceVariant),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
