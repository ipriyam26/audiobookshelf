import 'package:audiobookshelf/Controller/authortab_controller.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/extension.dart';
import 'package:audiobookshelf/Utils/filter.dart';
import 'package:audiobookshelf/View/home/widget/recent_authors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AuthorTab extends StatelessWidget {
  AuthorTab({super.key});

  // final HomeController homeController = Get.find<HomeController>();
  final AuthorTabController controller = Get.put(AuthorTabController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Authors",
                  style: Get.textTheme.titleLarge,
                ),
                // FilterItems(),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.desc.value = !controller.desc.value;
                        },
                        icon: Obx(
                          () => controller.desc.value
                              ? const Icon(Icons.keyboard_arrow_down)
                              : const Icon(Icons.keyboard_arrow_up_sharp),
                        )),
                    Stack(
                      children: [
                        PopupMenuButton<SortAuthorItem>(
                          icon: const Icon(Icons.sort),
                          onSelected: (SortAuthorItem result) {
                            controller.sort.value = result;
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<SortAuthorItem>>[
                            ...SortAuthorItem.values
                                .map(
                                  (filter) => PopupMenuItem<SortAuthorItem>(
                                    value: filter,
                                    child: Text(filter.label),
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Obx(() => Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                    controller.sort.value.label
                                        .split("")[0]
                                        .toUpperCase(),
                                    style: Get.textTheme.labelSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    )),
                              )),
                        )
                      ],
                    ),
                    Obx(() => IconButton(
                        onPressed: () {
                          controller.isGridView.value =
                              !controller.isGridView.value;
                        },
                        icon: IconAnimation(
                            condition: controller.isGridView.value))),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Obx(() => ListToGridAnimation(
                    child: controller.isGridView.value
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent:
                                  200.w, // Set the maximum width for items
                              mainAxisSpacing:
                                  4.0, // Spacing along the main axis
                              crossAxisSpacing:
                                  4.0, // Spacing along the cross axis
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              // Your builder function here
                              return AuthorItem(
                                  item: controller.authors[index]);
                            },
                            itemCount: controller.authors.length,
                          )
                        : ListView.builder(
                            itemCount: controller.authors.length,
                            itemBuilder: (context, index) {
                              return AuthorItem(
                                  item: controller.authors[index]);
                            },
                          ),
                  )))
        ],
      ),
    );
  }
}
