import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:audiobookshelf/Utils/series_item_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecentSeries extends StatelessWidget {
  RecentSeries({
    super.key,
  });

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Series", style: Get.theme.textTheme.titleLarge),
              Obx(() => IconButton(
                  onPressed: () {
                    controller.recentSeriesGridView.value =
                        !controller.recentSeriesGridView.value;
                  },
                  icon: IconAnimation(
                      condition: controller.recentSeriesGridView.value)))
            ],
          ),
        ),
        Obx(() {
          return Align(
            alignment: Alignment.center,
            child: ListToGridAnimation(
                child: controller.recentSeries.isEmpty
                    ? LoadingShimmer(
                        key: UniqueKey(), height: 184.h, width: 320.w)
                    : controller.recentSeriesGridView.value
                        ? SeriesItemCarousel(
                            key: UniqueKey(),
                            items: controller.recentSeries,
                            displayAuthor: true,
                            gridView: true,
                          )
                        : SeriesItemCarousel(
                            key: UniqueKey(),
                            items: controller.recentSeries,
                            displayAuthor: true,
                            gridView: false,
                          )),
          );
        })
      ],
    );
  }
}
