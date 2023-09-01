import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/View/home/widget/library_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContinueListening extends StatelessWidget {
  ContinueListening({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();
  final UserController userController = Get.find<UserController>();
  void _onGridButtonPressed() {
    homeController.continueListeningGridView.value =
        !homeController.continueListeningGridView.value;
  }

  @override
  Widget build(BuildContext context) {
    return userController.currentUser.value.mediaProgress!.isNotEmpty
        ? Obx(() => LibraryView(
              title: "Continue Listening",
              // ignore: invalid_use_of_protected_member
              items: homeController.mediaProgressionItems.value,
              condition: homeController.continueListeningGridView.value,
              onGridButtonPressed: _onGridButtonPressed,
            ))
        : Container();
  }
}
