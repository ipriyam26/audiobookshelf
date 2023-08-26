import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RecentAuthors extends StatelessWidget {
  RecentAuthors({
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
          child: Text("Recent Author", style: Get.theme.textTheme.titleLarge),
        ),
        Obx(() => homeController.recentAuthors.isNotEmpty
            ? AuthorItemCarousel(items: homeController.recentAuthors)
            : LoadingShimmer(
                height: 140.h,
                width: 138.w,
              )),
      ],
    );
  }
}

class AuthorItemCarousel extends StatelessWidget {
  AuthorItemCarousel({
    super.key,
    required this.items,
    this.showProgress = false,
  });

  final List<Author> items;
  final bool showProgress;
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
// Inside your build method:
    return Container(
      // width: Get.context!.width,
      color: Get.theme.colorScheme.background,
      height: 140.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: 130.w,
            height: 140.h,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: Card(
              //!TODO
              color: Colors.black54,
              elevation: 10,
              child: Stack(alignment: Alignment.bottomCenter, children: [
                Image.asset(
                  "assets/human.png",
                  height: 140.h,
                  width: 130.w,
                  fit: BoxFit.cover,
                  color: Get.theme.colorScheme.outline,
                ),
                Container(
                  width: 130.w,
                  height: 40.h,
                  color: Colors.black.withOpacity(0.6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        items[index].name!,
                        style: Get.theme.textTheme.titleMedium,
                      ),
                      Text("${items[index].libraryItems!.length} Books")
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
