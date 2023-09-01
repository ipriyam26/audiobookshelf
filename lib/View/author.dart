import 'package:audiobookshelf/Controller/author_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/library_item_carousel.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:audiobookshelf/Utils/series_item_carousel.dart';
import 'package:audiobookshelf/View/home/widget/drop_down_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class AuthorView extends StatelessWidget {
  const AuthorView({super.key, required this.item});
  final Author item;
  @override
  Widget build(BuildContext context) {
    final AuthorController controller = Get.put(AuthorController(item));

    // final SeriesController controller = Get.put(SeriesController(item: item));
    var searchNDrawer = [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            size: 28.sp,
          )),
      SizedBox(
        width: 12.w,
      ),
      Builder(
        builder: (context) => IconButton(
          onPressed: () {
            // Open the end drawer
            Scaffold.of(context).openEndDrawer();
          },
          icon: const FaIcon(FontAwesomeIcons.bars),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Get.theme.colorScheme.primary,
        centerTitle: false,
        title: Container(
          width: 180.w,
          margin: EdgeInsets.only(bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDownList(),
              Icon(
                Icons.cloud_done_outlined,
                color: Get.theme.colorScheme.primary,
              ),
            ],
          ),
        ),
        actions: searchNDrawer,
      ),
      body: ListView(
        children: [
          Material(
            elevation: 10,
            color: Colors.transparent,
            child: CachedNetworkImage(
              width: Get.width,
              imageUrl: controller.getAuthorImageUrl(),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 300.h,
                  width: Get.width,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/human.png",
                width: Get.width,
                fit: BoxFit.cover,
                color: Get.theme.colorScheme.outline,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0.h, horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  item.authorName,
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.headlineMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                if (item.asin != null) Text(item.asin),
                SizedBox(
                  height: 12.h,
                ),
                if (item.description != null)
                  ReadMoreText(
                    item.description,
                    style: Get.theme.textTheme.headlineSmall!
                        .copyWith(fontSize: 16.sp),
                    trimLines: 5,
                    colorClickableText: Get.theme.colorScheme.primary,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    // moreStyle:
                    // ,
                  ),
              ],
            ),
          ),
          if (item.libraryItems != null)
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Recently Added",
                              style: Get.theme.textTheme.titleLarge),

                          //add transition when controller.bookGridView.value is changed

                          Obx(() => IconButton(
                              onPressed: () {
                                controller.bookGridView.value =
                                    !controller.bookGridView.value;
                              },
                              icon: IconAnimation(
                                  condition: controller.bookGridView.value)))
                        ],
                      ),
                    ),
                    if (item.libraryItems!.isNotEmpty)
                      Obx(() => ListToGridAnimation(
                          child: controller.bookGridView.value
                              ? LibraryItemCarousel(
                                  key: UniqueKey(),
                                  items: item.libraryItems!,
                                  displayAuthor: false,
                                  gridView: true,
                                )
                              : LibraryItemCarousel(
                                  key: UniqueKey(),
                                  items: item.libraryItems!,
                                  displayAuthor: false,
                                )))
                  ],
                ),
              ],
            ),
          if (item.series != null && item.series!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Recent Series",
                          style: Get.theme.textTheme.titleLarge),
                      Obx(() => IconButton(
                          onPressed: () {
                            controller.seriesGridView.value =
                                !controller.seriesGridView.value;
                          },
                          icon: IconAnimation(
                              condition: controller.seriesGridView.value)))
                    ],
                  ),
                ),
                Obx(() {
                  return ListToGridAnimation(
                      child: controller.series.isEmpty
                          ? LoadingShimmer(
                              key: UniqueKey(), height: 184.h, width: 320.w)
                          : controller.seriesGridView.value
                              ? SeriesItemCarousel(
                                  key: UniqueKey(),
                                  items: controller.series,
                                  displayAuthor: false,
                                  gridView: true,
                                )
                              : SeriesItemCarousel(
                                  key: UniqueKey(),
                                  items: controller.series,
                                  displayAuthor: false,
                                ));
                })
              ],
            )
        ],
      ),
    );
  }
}
