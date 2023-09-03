import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:audiobookshelf/View/author.dart';
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20.h,
      ),
      Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recently Added", style: Get.theme.textTheme.titleLarge),

                //add transition when controller.bookGridView.value is changed

                Obx(() => IconButton(
                    onPressed: () {
                      homeController.recentAuthorsGridView.value =
                          !homeController.recentAuthorsGridView.value;
                    },
                    icon: IconAnimation(
                        condition: homeController.recentAuthorsGridView.value)))
              ],
            ),
          ),
          Obx(() => ListToGridAnimation(
              child: homeController.recentAuthors.isEmpty
                  ? LoadingShimmer(height: 140.h, width: 130.w)
                  : homeController.recentAuthorsGridView.value
                      ? AuthorItemCarousel(
                          key: UniqueKey(),
                          items: homeController.recentAuthors,
                          gridView: true,
                        )
                      : AuthorItemCarousel(
                          key: UniqueKey(),
                          items: homeController.recentAuthors,
                          gridView: false,
                        )))
        ],
      )
    ]);
  }
}

class AuthorItemCarousel extends StatelessWidget {
  AuthorItemCarousel({
    super.key,
    required this.items,
    // this.showProgress = false,
    this.gridView = false,
  });

  final List<Author> items;
  final bool gridView;
  // final bool showProgress;
  final homeController = Get.find<HomeController>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
// Inside your build method:
    return gridView
        ? Wrap(
            children: items
                .map((Author item) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      child: AuthorItem(
                        item: item,
                      ),
                    ))
                .toList())
        : Container(
            // width: Get.context!.width,
            color: Get.theme.colorScheme.background,
            height: 140.h,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return AuthorItem(item: items[index]);
              },
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
            ),
          );
  }
}

class AuthorItem extends StatelessWidget {
  const AuthorItem({
    super.key,
    required this.item,
  });

  final Author item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Get.toNamed("/author", arguments: item);
        Get.to(() => AuthorView(item: item));
      },
      child: Container(
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
                    item.name,
                    style: Get.theme.textTheme.titleMedium,
                  ),
                  Text("${item.bookCount} Books")
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
