import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/button.dart';
import 'package:audiobookshelf/View/home/home.dart';
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

  Map<String, int> convertToHours(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    return {'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
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
            TitleImage(itemId: item.id!),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                item.media.metadata!.title ?? "Failed to Load",
                style: Get.theme.textTheme.headlineMedium!
                    .copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
            const ActionButtons(),
            ProgressCard(item: item),
            BookMetadata(item: item),
            Description(item: item),
            ChapterList(item: item),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.h),
                width: Get.width,
                color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
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
                          child:
                              Text("${(item.media.audioFiles ?? []).length}"),
                        )
                      ],
                    ),
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      height: 40.h *
                          (item.media.audioFiles ?? [])
                              .length
                              .toDouble()
                              .clamp(0, 8),
                      child: ListView.builder(
                        shrinkWrap: true,

                        // physics: const (),
                        itemCount: (item.media.audioFiles ?? []).length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            // tileColor: ,
                            title: Text(
                              item.media.audioFiles![index].metadata!
                                      .filename ??
                                  "Failed to Load",
                              style: Get.theme.textTheme.headlineSmall!
                                  .copyWith(fontSize: 14.sp),
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
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
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
  const ProgressCard({
    super.key,
    required this.item,
  });

  final LibraryItem item;
  String getLeftOverTime() {
    try {
      final double leftTime =
          item.media.duration! - item.mediaProgress!.currentTime!;
      final int totalSeconds =
          leftTime.floor(); // Convert to nearest lower integer

      final int hours = totalSeconds ~/ 3600;
      final int minutes = (totalSeconds % 3600) ~/ 60;

      return '$hours hr $minutes min';
    } catch (e) {
      return "Not able to process";
    }
  }

  @override
  Widget build(BuildContext context) {
    return item.mediaProgress != null
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
                  Text(
                      "Your Progress:  ${(item.mediaProgress!.progress! * 100).toInt()}%",
                      style: Get.theme.textTheme.headlineSmall),
                  Text("${getLeftOverTime()} sec left",
                      style: Get.theme.textTheme.titleLarge!.copyWith(
                        color: Get.theme.colorScheme.outline,
                      )),
                ]),
          )
        : Container();
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.item,
  });

  final LibraryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: ReadMoreText(
        item.media.metadata!.description ?? "Failed to Load",
        style: Get.theme.textTheme.headlineSmall!.copyWith(fontSize: 16.sp),
        trimLines: 5,
        colorClickableText: Get.theme.colorScheme.primary,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        // moreStyle:
        // ,
      ),
    );
  }
}

class BookMetadata extends StatelessWidget {
  const BookMetadata({super.key, required this.item});
  final LibraryItem item;

  Map<String, int> convertToHours(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    return {'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  String getDuration() {
    try {
      final int totalSeconds =
          item.media.duration!.floor(); // Convert to nearest lower integer
      final Map<String, int> time = convertToHours(totalSeconds);
      final hour = time["hours"];
      final minutes = time["minutes"];
      return '$hour hr $minutes min';
    } catch (e) {
      return "Not able to process";
    }
  }

  String getChapterDuration(
    double start,
  ) {
    try {
      final time = convertToHours(start.toInt());
      final hour = time["hours"]!;
      final minutes = time["minutes"]!;
      final seconds = time["seconds"]!;
      String chaptertime = hour < 10 ? "0$hour" : "$hour";
      chaptertime += ":${minutes < 10 ? "0$minutes" : "$minutes"}";
      chaptertime += ":${seconds < 10 ? "0$seconds" : "$seconds"}";
      return chaptertime;
    } catch (e) {
      return "Not able to process";
    }
  }

  String handleJoins(List<dynamic>? listItems) {
    try {
      final genres = listItems!.join(", ");
      return genres;
    } catch (e) {
      return "Not able to process";
    }
  }

  String getGenres() {
    try {
      String genres = item.media.metadata!.series!.join(", ");
      return genres;
    } catch (e) {
      return "Not able to process";
    }
  }

  String getSeries() {
    try {
      String series =
          item.media.metadata!.series!.map((e) => e.name).join(", ");
      return series;
    } catch (e) {
      return "Not able to process";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.media.metadata!.authorName != null)
            MetadataRow(
              title: "AUTHOR",
              value: item.media.metadata!.authorName!,
            ),
          if (item.media.metadata!.series != null &&
              item.media.metadata!.series!.isNotEmpty)
            MetadataRow(
              title: "SERIES",
              value: getSeries(),
            ),
          if (item.media.duration != null)
            MetadataRow(
              title: "DURATION",
              value: getDuration(),
            ),
          if (item.media.metadata!.narrators != null &&
              item.media.metadata!.narrators!.isNotEmpty)
            MetadataRow(
              title: "NARRATOR",
              value: handleJoins(item.media.metadata!.narrators!),
            ),
          if (item.media.metadata!.genres != null &&
              item.media.metadata!.genres!.isNotEmpty)
            MetadataRow(
              title: "GENRE",
              value: handleJoins(
                item.media.metadata!.genres,
              ),
            ),
          if (item.media.metadata!.publishedYear != null)
            MetadataRow(
              title: "PUBLISHED",
              value: item.media.metadata!.publishedYear.toString(),
            ),
        ],
      ),
    );
  }
}

class ChapterList extends StatelessWidget {
  const ChapterList({
    super.key,
    required this.item,
  });

  final LibraryItem item;
  Map<String, int> convertToHours(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    return {'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  String getChapterDuration(
    double start,
  ) {
    try {
      final time = convertToHours(start.toInt());
      final hour = time["hours"]!;
      final minutes = time["minutes"]!;
      final seconds = time["seconds"]!;
      String chaptertime = hour < 10 ? "0$hour" : "$hour";
      chaptertime += ":${minutes < 10 ? "0$minutes" : "$minutes"}";
      chaptertime += ":${seconds < 10 ? "0$seconds" : "$seconds"}";
      return chaptertime;
    } catch (e) {
      return "Not able to process";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.h),
        width: Get.width,
        color: Get.theme.colorScheme.onSurface.withOpacity(0.1),
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
                  child: Text("${(item.media.chapters ?? []).length}"),
                )
              ],
            ),
          ),
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
              ),
              height: 40.h *
                  (item.media.audioFiles ?? []).length.toDouble().clamp(0, 8),
              child: ListView.builder(
                shrinkWrap: true,

                // physics: const (),
                itemCount: (item.media.chapters ?? []).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // tileColor: ,
                    title: Text(
                      item.media.chapters![index].title ?? "Failed to Load",
                      style: Get.theme.textTheme.headlineSmall!
                          .copyWith(fontSize: 14.sp),
                    ),
                    subtitle: Text(
                      getChapterDuration(item.media.chapters![index].start!),
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
            ),
          ],
        ),
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
    required this.itemId,
  });

  final String itemId;
  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      // alignment: Alignment.ce,
      imageUrl: homeController.getCoverUrl(itemId),
      height: Get.height * 0.4,
      width: Get.width,
      fit: BoxFit.fill,
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
    );
  }
}
