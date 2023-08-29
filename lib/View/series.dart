import 'package:audiobookshelf/Controller/series_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/View/home/home.dart';
import 'package:audiobookshelf/View/library_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class SeriesView extends StatelessWidget {
  const SeriesView({super.key, required this.item});
  final Series item;

  @override
  Widget build(BuildContext context) {
    final SeriesController controller = Get.put(SeriesController(item: item));
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: Material(
              elevation: 10,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child:
                    Text(item.nameCount, style: Get.theme.textTheme.titleLarge),
              ),
            ),
          ),
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
        body: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => LibraryItemView(
                    item: item.books[index],
                  ),
                  transition: Transition.cupertino,
                );
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12.w, top: 12.h),
                    child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 70.h,
                          width: 70.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      imageUrl: controller.getCoverUrl(index),
                      // height: 70.h,
                      // width: 70.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 70.h,
                          width: 70.h,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/book_placeholder.jpg",
                        // height: Get.height * 0.4,
                        height: 70.h,
                        width: 70.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12.w, top: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.books[index].title,
                            style: Get.theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "by ${item.books[index].authorName}",
                            style: Get.theme.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.onSurfaceVariant),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            item.books[index].media
                                .formatDuration(english: true),
                            style: Get.theme.textTheme.bodyMedium!.copyWith(
                                color: Get.theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: (item.books).length,
        ));
  }
}
