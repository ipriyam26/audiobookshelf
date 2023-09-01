import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/animation.dart';
import 'package:audiobookshelf/Utils/library_item_carousel.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({
    super.key,
    required this.items,
    required this.condition,
    required this.onGridButtonPressed,
    required this.title,
  });

  final List<LibraryItem> items;
  final bool condition;
  final Function onGridButtonPressed; // Add this line
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Get.theme.textTheme.titleLarge),
                  IconButton(
                      onPressed: () => onGridButtonPressed(),
                      icon: IconAnimation(condition: condition))
                ],
              ),
            ),
            ListToGridAnimation(
                child: items.isEmpty
                    ? LoadingShimmer(height: 184.h, width: 160.w)
                    : condition
                        ? LibraryItemCarousel(
                            key: UniqueKey(),
                            items: items,
                            displayAuthor: true,
                            showProgress: true,
                            gridView: true,
                          )
                        : LibraryItemCarousel(
                            key: UniqueKey(),
                            items: items,
                            displayAuthor: true,
                            showProgress: true,
                            gridView: false,
                          ))
          ],
        ),
      ],
    );
  }
}
