import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/series_tab_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/book_stack.dart';
import 'package:audiobookshelf/Utils/filter.dart';
import 'package:audiobookshelf/Utils/series_item_carousel.dart';
import 'package:audiobookshelf/View/series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SeriesTab extends StatelessWidget {
  SeriesTab({super.key});
  final SeriesTabController seriesTabController =
      Get.put(SeriesTabController());
  final HomeController homeController = Get.find();
  final UserController userController = Get.find();
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
                  "Series",
                  style: Get.textTheme.titleLarge,
                ),
                // FilterItems(),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          seriesTabController.updateOrderAndRefresh();
                        },
                        icon: Obx(
                          () => seriesTabController.desc.value
                              ? const Icon(Icons.keyboard_arrow_down)
                              : const Icon(Icons.keyboard_arrow_up_sharp),
                        )),
                    Stack(
                      children: [
                        PopupMenuButton<SortSeriesItem>(
                          icon: const Icon(Icons.sort),
                          onSelected: (SortSeriesItem result) {
                            seriesTabController.updateSortAndRefresh(result);
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SortSeriesItem>>[
                            ...SortSeriesItem.values
                                .map(
                                  (filter) => PopupMenuItem<SortSeriesItem>(
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
                                    seriesTabController.sort.value.label
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
                          seriesTabController.isGridView.value =
                              !seriesTabController.isGridView.value;
                        },
                        icon: IconAnimation(
                            condition: seriesTabController.isGridView.value))),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Obx(() => ListToGridAnimation(
                    child: !seriesTabController.isGridView.value
                        ? PagedListView(
                            pagingController:
                                seriesTabController.pagingController,
                            builderDelegate: PagedChildBuilderDelegate<Series>(
                              itemBuilder: (context, item, index) =>
                                  SeriesItem(item: item, displayAuthor: true),
                            ))
                        : ListViewSeries(),
                  )))
        ],
      ),
    );
  }
}

class ListViewSeries extends StatelessWidget {
  ListViewSeries({
    super.key,
  });

  final SeriesTabController seriesTabController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PagedListView(
        shrinkWrap: true,
        pagingController: seriesTabController.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Series>(
            itemBuilder: (context, item, index) {
          return InkWell(
            onTap: () {
              Get.to(
                () => SeriesView(item: item),
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
                        scaleFactor: 0.4,
                        images: seriesTabController.getCoverUrl(item)),
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
                          // Text("${item.books.length} Books",
                          //     style: Get.textTheme.bodyMedium!.copyWith(
                          //         color:
                          //             Get.theme.colorScheme.onSurfaceVariant)),
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
