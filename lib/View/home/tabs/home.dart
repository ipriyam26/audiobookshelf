import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/View/home/widget/continue_listening.dart';
import 'package:audiobookshelf/View/home/widget/library_item_carousel.dart';
import 'package:audiobookshelf/View/home/widget/series_item_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  HomeTab({
    super.key,
  });

  final userController = Get.find<UserController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ContinueListening(), RecentLibraryItems(), RecentSeries()],
    );
  }

// ignore: non_constant_identifier_names
}

class RecentSeries extends StatelessWidget {
  RecentSeries({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 12.w, bottom: 12.h),
          child: Text("Recent Series", style: Get.theme.textTheme.titleMedium),
        ),
        Obx(() => homeController.recentSeries.isNotEmpty
            ? SeriesItemCarousel(items: homeController.recentSeries)
            : Container()),
      ],
    );
  }
}

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
              child: Text("Recently Added",
                  style: Get.theme.textTheme.titleMedium),
            ),
            Obx(() => homeController.recentLibraryItems.isNotEmpty
                ? LibraryItemCarousel(items: homeController.recentLibraryItems)
                : Container()),
          ],
        ),
      ],
    );
  }
}
