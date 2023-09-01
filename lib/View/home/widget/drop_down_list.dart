import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/library_response/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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

            value: homeController.dropdownValue.value,
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
              homeController.dropdownValue.value = newValue!;
            },
          ),
        ));
  }
}
