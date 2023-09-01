import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/View/home/tabs/books.dart';
import 'package:audiobookshelf/View/home/tabs/home.dart';
import 'package:audiobookshelf/View/home/widget/drop_down_list.dart';
import 'package:audiobookshelf/View/home/widget/end_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(HomeController());

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

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        endDrawer: const EndDrawer(),
        appBar: AppBar(
          // backgroundColor: Get.theme.colorScheme.primary,
          bottom: TabBar(
            indicatorColor: Get.theme.colorScheme.primary,
            unselectedLabelColor: Colors.grey,
            labelColor: Get.theme.colorScheme.primary,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.home,
                size: 20.sp,
              )),
              Tab(
                  icon: Icon(
                Icons.headset,
                size: 20.sp,
              )),
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.linesLeaning,
                size: 20.sp,
              )),
              Tab(
                  icon: Icon(
                Icons.shelves,
                size: 20.sp,
              )),
              Tab(
                  icon: FaIcon(
                FontAwesomeIcons.users,
                size: 20.sp,
              )),
            ],
          ),
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
        body: TabBarView(
          children: [
            HomeTab(),

            BookTab(),
            const Icon(Icons.book, size: 350),
            const Icon(Icons.shelves, size: 350),
            const Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}
