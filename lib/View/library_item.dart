import 'dart:ui';

import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/library_item_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/button.dart';
import 'package:audiobookshelf/View/home/widget/drop_down_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

class LibraryItemView extends StatelessWidget {
  LibraryItemView({super.key, required this.item});
  final LibraryItem item;

  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LibraryItemController(item));

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
            TitleImage(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                controller.item.value.title,
                style: Get.theme.textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const ActionButtons(),
            ProgressCard(),
            BookMetadata(),
            Description(),
            ChapterList(),
            AudioFiles()
          ],
        ));
  }
}

class AudioFiles extends StatelessWidget {
  AudioFiles({
    super.key,
  });

  final LibraryItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
      ),
      child: ExpansionTile(
        title: SizedBox(
          height: 40.h,
          child: Row(
            children: [
              Text(
                "Audio Tracks",
                style: Get.theme.textTheme.headlineSmall,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Get.theme.colorScheme.background,
                ),
                child: Obx(() =>
                    Text(controller.item.value.audioFiles.length.toString())),
              )
            ],
          ),
        ),
        children: [
          Obx(() => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                height: 40.h *
                    controller.item.value.audioFiles.length
                        .toDouble()
                        .clamp(0, 8),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.item.value.audioFiles.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        controller.getAudioFileNames(index),
                        style: Get.theme.textTheme.headlineSmall!
                            .copyWith(fontSize: 14.sp),
                      ),
                      trailing: Text(
                        controller.item.value.audioFiles[index].getDuration(),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 36.h,
          width: 240.w,
          child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                size: 32.w,
              ),
              label: Text(
                "Stream",
                style: Get.theme.textTheme.headlineSmall,
              )),
        ),
        OptionIconButton(
          icon: Icons.download_rounded,
          onPressed: () {},
        ),
        OptionIconButton(
          icon: Icons.more_vert_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

class ProgressCard extends StatelessWidget {
  ProgressCard({
    super.key,
  });

  final LibraryItemController controller = Get.find<LibraryItemController>();

  @override
  Widget build(BuildContext context) {
    return controller.item.value.mediaProgress != null
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
            width: Get.width,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(controller.item.value.itemProgress,
                      style: Get.theme.textTheme.headlineSmall),
                  Text(controller.getLeftOverTime(),
                      style: Get.theme.textTheme.titleLarge!.copyWith(
                        color: Get.theme.colorScheme.outline,
                      )),
                ]),
          )
        : Container();
  }
}

class Description extends StatelessWidget {
  Description({
    super.key,
  });

  final LibraryItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return controller.item.value.description.isNotEmpty
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: ReadMoreText(
              controller.item.value.description,
              style:
                  Get.theme.textTheme.headlineSmall!.copyWith(fontSize: 16.sp),
              trimLines: 5,
              colorClickableText: Get.theme.colorScheme.primary,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Show less',
              // moreStyle:
              // ,
            ),
          )
        : Container();
  }
}

class BookMetadata extends StatelessWidget {
  BookMetadata({super.key});
  final LibraryItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
      child: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (controller.item.value.authorName.isNotEmpty)
                MetadataRow(
                  title: "AUTHOR",
                  value: controller.item.value.authorName,
                ),
              if (controller.item.value.serieNames.isNotEmpty)
                MetadataRow(
                  title: "SERIES",
                  value: controller.item.value.serieNames,
                ),
              if (controller.item.value.media.duration != null)
                MetadataRow(
                  title: "DURATION",
                  value: controller.item.value.getDuration(),
                ),
              if (controller.item.value.narratorNames.isNotEmpty)
                MetadataRow(
                  title: "NARRATOR",
                  value: controller.item.value.narratorNames,
                ),
              if (controller.item.value.genreNames.isNotEmpty)
                MetadataRow(
                  title: "GENRE",
                  value: controller.item.value.genreNames,
                ),
              if (controller.item.value.publishedYear.isNotEmpty)
                MetadataRow(
                  title: "PUBLISHED",
                  value: controller.item.value.publishedYear,
                ),
            ],
          )),
    );
  }
}

class ChapterList extends StatelessWidget {
  ChapterList({
    super.key,
  });

  final LibraryItemController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
      ),
      child: ExpansionTile(
        title: SizedBox(
          height: 40.h,
          child: Row(
            children: [
              Text(
                "Chapters",
                style: Get.theme.textTheme.headlineSmall,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Get.theme.colorScheme.background,
                ),
                child: Obx(() =>
                    Text(controller.item.value.chapterList.length.toString())),
              )
            ],
          ),
        ),
        children: [
          Obx(() => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                height: 40.h *
                    controller.item.value.chapterList.length
                        .toDouble()
                        .clamp(0, 8),
                child: ListView.builder(
                  shrinkWrap: true,

                  // physics: const (),
                  itemCount: controller.item.value.chapterList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // tileColor: ,
                      title: Text(
                        controller.getChapterNames(index),
                        style: Get.theme.textTheme.headlineSmall!
                            .copyWith(fontSize: 14.sp),
                      ),
                      subtitle: Text(
                        controller.getChapterDuration(
                            controller.item.value.chapterList[index].start!),
                        style: Get.theme.textTheme.headlineSmall!.copyWith(
                          fontSize: 14.sp,
                          color: Get.theme.colorScheme.outline,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_arrow,
                          size: 24.sp,
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }
}

class MetadataRow extends StatelessWidget {
  const MetadataRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 200.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: Get.theme.textTheme.headlineSmall!.copyWith(
                fontSize: 20.sp,
                color: Get.theme.colorScheme.outline,
              ),
            ),
          ),
          SizedBox(
            width: Get.width - 160.w,
            child: Text(
              value,
              style:
                  Get.theme.textTheme.headlineSmall!.copyWith(fontSize: 16.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleImage extends StatelessWidget {
  TitleImage({
    super.key,
    // required this.itemId,
  });

  // final String itemId = Get.fi;
  final LibraryItemController controller = Get.find();
  final HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Blurred Background
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: controller.getCoverUrl(),
                height: Get.height * 0.4,
                width: Get.width,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: Get.height * 0.4,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "assets/book_placeholder.jpg",
                  height: Get.height * 0.4,
                  width: Get.width,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),

            // Actual Image
            CachedNetworkImage(
              imageUrl: controller.getCoverUrl(),
              height: Get.height * 0.4,
              width: Get.width,
              fit: BoxFit.contain,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: Get.height * 0.4,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/book_placeholder.jpg",
                height: Get.height * 0.4,
                width: Get.width,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        // use controller.item.value.progress.value to display a progress bar
        Obx(() {
          if (controller.item.value.mediaProgress != null) {
            return Container(
              height: 4.h,
              width: (controller.item.value.mediaProgress!.progress ?? 0) *
                  Get.width,
              color: Get.theme.colorScheme.primary,
            );
          } else {
            return Container();
          }
        })
      ],
    );
  }
}
