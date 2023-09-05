import 'dart:async';

import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/search_controller.dart';
import 'package:audiobookshelf/Model/search_response/search_response.dart';
import 'package:audiobookshelf/View/home/tabs/author.dart';
import 'package:audiobookshelf/View/home/tabs/books.dart';
import 'package:audiobookshelf/View/home/tabs/collection.dart';
import 'package:audiobookshelf/View/home/tabs/home.dart';
import 'package:audiobookshelf/View/home/tabs/series.dart';
import 'package:audiobookshelf/View/home/widget/drop_down_list.dart';
import 'package:audiobookshelf/View/home/widget/end_drawer.dart';
import 'package:audiobookshelf/View/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(HomeController());
  final searchController = Get.put(SearchItemController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => DefaultTabController(
          length: homeController.isSearching.value ? 1 : 5,
          child: Scaffold(
            endDrawer: const EndDrawer(),
            appBar: AppBar(
              // backgroundColor: Get.theme.colorScheme.primary,
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Obx(() {
                    if (homeController.isSearching.value) {
                      return TabBar(
                        indicatorColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.white,
                        tabs: [
                          //make a textfield to search
                          Tab(
                            child: TextField(
                              autofocus: true,
                              onChanged: (value) {
                                if (value.isEmpty || value.length < 3) {
                                  searchController.isTyping.value = false;
                                  return;
                                }
                                if (homeController.debounce?.isActive ??
                                    false) {
                                  homeController.debounce?.cancel();
                                }
                                homeController.debounce = Timer(
                                  const Duration(milliseconds: 2000),
                                  () {
                                    searchController.getSearchResults(value);
                                  },
                                );
                              },
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: Get.theme.textTheme.bodyMedium,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const TabBarCustom();
                  })),
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
              actions: [
                IconButton(
                    onPressed: () {
                      homeController.isSearching.value =
                          !homeController.isSearching.value;
                      if (searchController.isSearching.value) {
                        searchController.isSearching.value = false;
                        searchController.results.value = SearchResponse.empty();
                      }
                    },
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
              ],
            ),
            body: Obx(() => homeController.isSearching.value
                ? const TabBarView(
                    children: [
                      SearchView(),
                    ],
                  )
                : TabBarView(
                    children: [
                      HomeTab(),

                      BookTab(),
                      // const Icon(Icons.book, size: 350),
                      SeriesTab(),
                      // const Icon(Icons.shelves, size: 350),
                      CollectionTab(),
                      AuthorTab(),
                    ],
                  )),
          ),
        ));
  }
}

class TabBarCustom extends StatelessWidget {
  const TabBarCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
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
    );
  }
}
