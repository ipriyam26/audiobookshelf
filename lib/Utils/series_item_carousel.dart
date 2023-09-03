import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/Utils/grouped_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';

class SeriesItemCarousel extends StatelessWidget {
  SeriesItemCarousel({
    super.key,
    required this.items,
    this.showProgress = false,
    this.displayAuthor = true,
    this.gridView = false,
  });

  final List<Series> items;
  final bool showProgress;
  final bool gridView;
  final homeController = Get.find<HomeController>();

  final bool displayAuthor;
  @override
  Widget build(BuildContext context) {
    return gridView
        ? Wrap(
            children: items
                .map((Series item) => Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: GroupedItemView(
                          item: item, displayAuthor: displayAuthor),
                    ))
                .toList())
        : SizedBox(
            height: displayAuthor ? 204.h : 184.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GroupedItemView(
                    item: items[index], displayAuthor: displayAuthor);
              },
              itemCount: items.length,
            ),
          );
  }
}
