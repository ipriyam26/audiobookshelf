import 'package:audiobookshelf/Controller/series_controller.dart';
import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:audiobookshelf/View/home/widget/drop_down_list.dart';
import 'package:audiobookshelf/View/home/widget/library_item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class GroupedView extends StatelessWidget {
  const GroupedView({super.key, required this.item});
  final GroupedItems item;

  @override
  Widget build(BuildContext context) {
    final SeriesController controller = Get.put(SeriesController(item: item));
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

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Get.theme.colorScheme.primary,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.h),
            child: Material(
              elevation: 10,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                child:
                    Text(item.nameCount, style: Get.theme.textTheme.titleLarge),
              ),
            ),
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
        body: ListView.builder(
          itemBuilder: (context, index) {
            final String imageUrl = controller.getCoverUrl(index);
            return LibraryItemListView(
              item: item.books[index],
              imageUrl: imageUrl,
            );
          },
          itemCount: (item.books).length,
        ));
  }
}
