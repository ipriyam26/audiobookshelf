import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/View/home/widget/library_item_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContinueListening extends StatelessWidget {
  ContinueListening({
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
          child: Text("Continue Listening",
              style: Get.theme.textTheme.titleMedium),
        ),
        Obx(() => homeController.mediaProgressionItems.isNotEmpty
            ? LibraryItemCarousel(
                items: homeController.mediaProgressionItems,
                showProgress: true,
              )
            : Container()),
      ],
    );
  }
}
