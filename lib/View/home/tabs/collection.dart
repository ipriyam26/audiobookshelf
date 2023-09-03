import 'package:audiobookshelf/Controller/collections_controller.dart';
import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/list_view_grouped.dart';
import 'package:audiobookshelf/Utils/grouped_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CollectionTab extends StatelessWidget {
  CollectionTab({super.key});
  final CollectionTabController controller = Get.put(CollectionTabController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Collection",
                  style: Get.textTheme.titleLarge,
                ),
                // FilterItems(),
                Row(
                  children: [
                    Obx(
                      () => IconButton(
                        onPressed: () {
                          controller.isGridView.value =
                              !controller.isGridView.value;
                        },
                        icon: IconAnimation(
                            condition: controller.isGridView.value),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () => ListToGridAnimation(
                child: !controller.isGridView.value
                    ? PagedListView(
                        pagingController: controller.pagingController,
                        builderDelegate:
                            PagedChildBuilderDelegate<GroupedItems>(
                          itemBuilder: (context, item, index) =>
                              GroupedItemView(item: item, displayAuthor: false),
                        ),
                      )
                    : ListViewGrouped(controller: controller),
              ),
            ),
          )
        ],
      ),
    );
  }
}
