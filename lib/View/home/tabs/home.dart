import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/View/home/widget/continue_listening.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeTab extends StatelessWidget {
  HomeTab({
    super.key,
  });

  final userController = Get.find<UserController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 20.h,
        ),
        ContinueListening(),
      ],
    );
  }

// ignore: non_constant_identifier_names
}
