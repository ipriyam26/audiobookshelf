import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/library_response/library.dart';
import 'package:audiobookshelf/View/home/tabs/home.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
            const Icon(Icons.directions_transit, size: 350),
            const Icon(Icons.book, size: 350),
            const Icon(Icons.shelves, size: 350),
            const Icon(Icons.directions_car, size: 350),
          ],
        ),
      ),
    );
  }
}

class DropDownList extends StatelessWidget {
  DropDownList({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          // color: Get.theme.colorScheme.background,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
              color: Get.theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(4.r)),
          child: DropdownButton<Library>(
            underline: Container(),

            value: homeController.dropdownvalue.value,
            // Down Arrow Icon
            icon: Container(),
            // Array list of items
            items: homeController.items.map((Library item) {
              return DropdownMenuItem(
                value: item,
                child: SizedBox(
                    child: Row(
                  children: [
                    const Icon(Icons.language),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 100.w, // Set your maximum width here
                      child: Text(
                        item.name!,
                        style: Get.theme.textTheme.titleLarge,
                        overflow: TextOverflow
                            .ellipsis, // Add this line to handle overflow
                      ),
                    ),
                  ],
                )),
              );
            }).toList(),
            onChanged: (Library? newValue) {
              homeController.dropdownvalue.value = newValue!;
            },
          ),
        ));
  }
}

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
