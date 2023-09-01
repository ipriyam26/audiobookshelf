import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/View/home/widget/library_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentLibraryItems extends StatelessWidget {
  RecentLibraryItems({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();
  void _onGridButtonPressed() {
    homeController.recentLibraryItemsGridView.value =
        !homeController.recentLibraryItemsGridView.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => LibraryView(
        items: homeController.recentLibraryItems,
        condition: homeController.recentLibraryItemsGridView.value,
        onGridButtonPressed: _onGridButtonPressed,
        title: "Recently Added"));
  }
}
