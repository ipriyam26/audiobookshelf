import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/View/home/widget/library_card_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
    return CarouselSlider.builder(
      options: CarouselOptions(
          enlargeCenterPage: false,
          viewportFraction: 0.9,
          enableInfiniteScroll: false),
      itemCount: items.length,
      itemBuilder: (context, index, realIdx) {
        return Column(
          // mainAxisAlignment: Main,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BookStack(
                images: items[index]
                    .books!
                    .map((book) => homeController.getCoverUrl(book.id!))
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
                  items[index].books![0].media!.metadata!.authorName!,
                  style: Get.theme.textTheme.titleSmall!
                      .copyWith(color: Get.theme.colorScheme.outline),
                ),
              ],
            )
          ],
        );
      },
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

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4.w),
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              height: 140.h,
              width: width,
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
              )),
        ),
      ],
    );
  }
}
