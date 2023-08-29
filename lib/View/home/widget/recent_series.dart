import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:audiobookshelf/View/series.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
          child: Text("Recent Series", style: Get.theme.textTheme.titleLarge),
        ),
        Obx(() => homeController.recentSeries.isNotEmpty
            ? SeriesItemCarousel(items: homeController.recentSeries)
            : LoadingShimmer(height: 184.h, width: Get.width * 0.9)),
      ],
    );
  }
}

class SeriesItemCarousel extends StatelessWidget {
  SeriesItemCarousel({
    super.key,
    required this.items,
    this.showProgress = false,
  });

  final List<Series> items;
  final bool showProgress;
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // push the SeriesView screen
              Get.to(
                () => SeriesView(item: items[index]),
                transition: Transition.cupertino,
              );
            },
            child: Column(
              // mainAxisAlignment: Main,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BookStack(
                    images: items[index]
                        .books!
                        .map((book) => homeController.getCoverUrl(book.id))
                        .toList()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(items[index].name ?? "",
                        style: Get.theme.textTheme.titleLarge!
                            .copyWith(fontWeight: FontWeight.w400),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      items[index].books![0].media.metadata.authorName ?? "",
                      style: Get.theme.textTheme.titleSmall!
                          .copyWith(color: Get.theme.colorScheme.outline),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: items.length,
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
    double width = MediaQuery.of(context).size.width * 0.9;
    double overlap = (width - 140.h) / (images.length - 1);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 140.h,
      width: width,
      child: Card(
        elevation: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: Stack(
            children: [
              for (int i = 0; i < images.length; i++)
                Positioned(
                  left: i * overlap,
                  child: CachedNetworkImage(
                    imageUrl: images[i],
                    height: 140.h,
                    width: 144.h,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 140.h,
                        width: 144.h,
                        color: Colors.white,
                      ),
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
        ),
        // margin: EdgeInsets.symmetric(horizontal: 10.w),
      ),
    );
  }
}
