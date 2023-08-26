import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Utils/library_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibraryItemCarousel extends StatelessWidget {
  const LibraryItemCarousel({
    super.key,
    required this.items,
    this.showProgress = false,
  });

  final List<LibraryItem> items;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 184.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child:
                LibraryItemCard(item: items[index], showProgress: showProgress),
          );
        },
      ),
    );
  }
}
