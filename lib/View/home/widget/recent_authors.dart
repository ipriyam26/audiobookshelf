import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/View/author.dart';
import 'package:audiobookshelf/View/home/widget/library_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RecentAuthors extends StatelessWidget {
  RecentAuthors({
    super.key,
  });

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return homeController.recentAuthors.isEmpty
        ? Container()
        : Obx(() => LibraryView(
              items: homeController.recentAuthors.value,
              title: "Recent Authors",
              isGridView: homeController.recentAuthorsGridView,
            ));
  }
}

class AuthorItemCarousel extends StatelessWidget {
  const AuthorItemCarousel({
    super.key,
    required this.items,
    // this.showProgress = false,
    this.gridView = false,
  });

  final List<Author> items;
  final bool gridView;

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
  AuthorItem({
    super.key,
    required this.item,
  });

  final Author item;
  final UserController userController = Get.find<UserController>();

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
            CachedNetworkImage(
              width: 130.w,
              height: 140.h,
              fit: BoxFit.cover,
              httpHeaders: {
                "Authorization":
                    "Bearer ${userController.currentUser.value.token}"
              },
              imageUrl: item.getAuthorUrl(userController.server.value,
                  userController.currentUser.value.token!),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 140.h,
                  width: Get.width,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/human.png",
                width: 130.w,
                fit: BoxFit.cover,
                color: Get.theme.colorScheme.outline,
              ),
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
                    overflow: TextOverflow.ellipsis,
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
