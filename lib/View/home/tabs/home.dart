import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/View/home/widget/continue_listening.dart';
import 'package:audiobookshelf/View/home/widget/library_item_carousel.dart';
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
      children: [
        SizedBox(
          height: 20.h,
        ),
        ContinueListening(),
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
            Obx(() => homeController.recentlyAddedItems.isNotEmpty
                ? LibraryItemCarousel(items: homeController.recentlyAddedItems)
                : Container()),
          ],
        )
      ],
    );
  }

// ignore: non_constant_identifier_names
}
