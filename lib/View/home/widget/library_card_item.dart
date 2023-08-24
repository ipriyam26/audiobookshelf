import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LibraryItemCard extends StatelessWidget {
  final int idx;
  LibraryItemCard({super.key, required this.idx});
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: Main,
      children: [
        Material(
          elevation: 16.r,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.w),
            child: imageNProgress(idx),
          ),
        ),
        titleNauthor(idx)
      ],
    );
  }

  Column imageNProgress(int idx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          homeController
              .getCoverUrl(homeController.mediaProgressionItems[idx].id!),
          height: 140.h,
          width: 144.h,
          fit: BoxFit.fitWidth,
        ),
        // make two containers one green one black, length of green depends on progress

        progressBar(idx)
      ],
    );
  }

  Container progressBar(int idx) {
    return Container(
      // alignment: Alignment.topLeft,
      height: 4.h,
      width: homeController.mediaProgressionItems[idx].mediaProgress.progress! *
          140.h,
      color: Get.theme.colorScheme.primary,
    );
  }

  Column titleNauthor(int idx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            homeController.mediaProgressionItems[idx].media!.metadata!.title ??
                "",
            style: Get.theme.textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        SizedBox(
          height: 4.h,
        ),
        Text(
          homeController.getAuthor(idx),
          style: Get.theme.textTheme.titleSmall!
              .copyWith(color: Get.theme.colorScheme.outline),
        ),
      ],
    );
  }
}
