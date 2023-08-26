import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Utils/library_item_carousel.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecentLibraryItems extends StatelessWidget {
  RecentLibraryItems({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 12.w, bottom: 12.h),
              child:
                  Text("Recently Added", style: Get.theme.textTheme.titleLarge),
            ),
            Obx(() => homeController.recentLibraryItems.isNotEmpty
                ? LibraryItemCarousel(items: homeController.recentLibraryItems)
                : LoadingShimmer(
                    height: 140.h,
                    width: 144.h,
                  )),
          ],
        ),
      ],
    );
  }
}
