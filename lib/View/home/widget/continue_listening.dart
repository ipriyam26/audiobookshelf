import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/View/home/widget/library_card_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContinueListening extends StatelessWidget {
  ContinueListening({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 12.w, bottom: 12.h),
          child: Text("Continue Listening",
              style: Get.theme.textTheme.titleMedium),
        ),
        Obx(() => homeController.mediaProgressionItems.isNotEmpty
            ? RecentLibraryItems(homeController: homeController)
            : Container()),
      ],
    );
  }
}

class RecentLibraryItems extends StatelessWidget {
  const RecentLibraryItems({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          // aspectRatio: 1.8,
          enlargeCenterPage: false,
          viewportFraction: 1,
          enableInfiniteScroll: false),
      itemCount: (homeController.mediaProgressionItems.length / 2).round(),
      itemBuilder: (context, index, realIdx) {
        final int first = index * 2;
        final int second = first + 1;
        return Row(
          children: [first, second].map((idx) {
            return Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: LibraryItemCard(idx: idx),
                ));
          }).toList(),
        );
      },
    );
  }
}

// class LibraryItemCarousel extends StatelessWidget {
//   const LibraryItemCarousel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
