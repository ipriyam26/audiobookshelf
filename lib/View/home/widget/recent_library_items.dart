import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/View/home/widget/library_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentLibraryItems extends StatelessWidget {
  RecentLibraryItems({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => LibraryView(
        // ignore: invalid_use_of_protected_member
        items: homeController.recentLibraryItems.value,
        // condition: homeController.recentLibraryItemsGridView.value,
        isGridView: homeController.recentLibraryItemsGridView,
        // onGridButtonPressed: _onGridButtonPressed,
        title: "Recently Added"));
  }
}
