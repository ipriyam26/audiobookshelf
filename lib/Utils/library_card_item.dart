import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/View/library_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class LibraryItemCard extends StatelessWidget {
  // final int idx;
  final bool showProgress;
  final LibraryItem item;
  LibraryItemCard({super.key, required this.showProgress, required this.item});
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return LibraryItemProvider(
      item: item,
      child: InkWell(
        onTap: () {
          Get.to(
            () => LibraryItemView(item: item),
            transition: Transition.cupertino,
          );
        },
        child: SizedBox(
          width: 144.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 16.r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.w),
                  child: ImageNProgress(showProgress: showProgress),
                ),
              ),
              const TitleNAuthor()
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryItemProvider extends InheritedWidget {
  final LibraryItem item;

  const LibraryItemProvider({
    Key? key,
    required this.item,
    required Widget child,
  }) : super(key: key, child: child);

  static LibraryItem itemOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LibraryItemProvider>()!
        .item;
  }

  @override
  bool updateShouldNotify(covariant LibraryItemProvider oldWidget) {
    return item != oldWidget.item;
  }
}

class ImageNProgress extends StatelessWidget {
  final bool showProgress;

  const ImageNProgress({super.key, required this.showProgress});

  @override
  Widget build(BuildContext context) {
    final item = LibraryItemProvider.itemOf(context);
    final homeController = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: homeController.getCoverUrl(item.id!),
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
        if (showProgress && item.mediaProgress != null) ProgressBar(item: item)
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  final LibraryItem item;

  const ProgressBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.h,
      width: item.mediaProgress!.progress! * 140.h,
      color: Get.theme.colorScheme.primary,
    );
  }
}

class TitleNAuthor extends StatelessWidget {
  const TitleNAuthor({super.key});

  @override
  Widget build(BuildContext context) {
    final item = LibraryItemProvider.itemOf(context);
    final homeController = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.media!.metadata!.title ?? "",
            style: Get.theme.textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        SizedBox(
          height: 4.h,
        ),
        Text(
          homeController.getAuthor(item),
          style: Get.theme.textTheme.titleSmall!
              .copyWith(color: Get.theme.colorScheme.outline),
        ),
      ],
    );
  }
}
