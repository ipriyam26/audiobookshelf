import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/View/series.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
                      child:
                          SeriesItem(item: item, displayAuthor: displayAuthor),
                    ))
                .toList())
        : SizedBox(
            height: displayAuthor ? 200.h : 180.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SeriesItem(
                    item: items[index], displayAuthor: displayAuthor);
              },
              itemCount: items.length,
            ),
          );
  }
}

class SeriesItem extends StatelessWidget {
  SeriesItem({
    super.key,
    required this.item,
    required this.displayAuthor,
  });

  final Series item;
  final HomeController homeController = Get.find();
  final bool displayAuthor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // push the SeriesView screen
        Get.to(
          () => SeriesView(item: item),
          transition: Transition.cupertino,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        height: displayAuthor ? 184.h : 164.h,
        width: 320.w,
        child: Column(
          // mainAxisAlignment: Main,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (item.books.isNotEmpty)
              BookStack(
                  images: item.books
                      .map((book) => homeController.getCoverUrl(book.id))
                      .toList()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(item.name ?? "",
                    style: Get.theme.textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                if (displayAuthor)
                  Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        item.books[0].media.metadata.authorName ?? "",
                        style: Get.theme.textTheme.titleSmall!
                            .copyWith(color: Get.theme.colorScheme.outline),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BookStack extends StatelessWidget {
  // Add paths to your book images
  final List<String> images;

  const BookStack({super.key, required this.images});
  @override
  Widget build(BuildContext context) {
    double width = 320.w;
    double overlap =
        images.length > 1 ? (width - 140.h) / (images.length - 1) : 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 140.h,
      width: width,
      child: Card(
        elevation: 10,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(10.r),
        // ),
        child: images.length == 1
            ? CachedNetworkImage(
                imageUrl: images[0],
                fit: BoxFit.cover,
              )
            : Stack(
                children: [
                  for (int i = 0; i < images.length; i++)
                    Positioned(
                      left: i * overlap,
                      child: CachedNetworkImage(
                        imageUrl: images[i],
                        height: 140.h,
                        width: 144.h,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => Container(
                          height: 140.h,
                          width: 144.h,
                          color: Colors.white,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/book_placeholder.jpg",
                          height: 140.h,
                          width: 144.h,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                ],
              ),

        // margin: EdgeInsets.symmetric(horizontal: 10.w),
      ),
    );
  }
}
