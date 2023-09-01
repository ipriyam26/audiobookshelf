import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/View/library_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LibraryItemListView extends StatelessWidget {
  final String imageUrl;

  const LibraryItemListView(
      {super.key, required this.item, required this.imageUrl});

  final LibraryItem item;
  // final GetxController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => LibraryItemView(
            item: item,
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
              imageUrl: imageUrl,
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
                    item.title,
                    style: Get.theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "by ${item.authorName}",
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: Get.theme.colorScheme.onSurfaceVariant),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  if (item.media.formatDuration(english: true).isNotEmpty)
                    Text(
                      item.media.formatDuration(english: true),
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
  }
}
