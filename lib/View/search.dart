import 'package:audiobookshelf/Controller/search_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/View/home/widget/library_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    SearchItemController searchController = Get.find();

    return Scaffold(
      body: Obx(
        () => searchController.isTyping.value
            ? Center(
                child: Container(
                  margin: EdgeInsets.all(10.w),
                  child: Text(
                    "Searching...",
                    style: Get.theme.textTheme.bodyMedium,
                  ),
                ),
              )
            : ListView(
                // height: 300.h,
                children: [
                  searchController.results.value.book.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            LibraryView<LibraryItem>(
                                items: searchController.results.value.book
                                    .where((element) =>
                                        element.matchKey == "title" ||
                                        element.matchKey == "subtitle")
                                    .map((e) => e.libraryItem)
                                    .toList(),
                                isGridView:
                                    searchController.libraryItemsGridViewTitle,
                                title: "Books (Title/Subtitle)"),
                            LibraryView<LibraryItem>(
                                items: searchController.results.value.book
                                    .where((element) =>
                                        element.matchKey == "authors")
                                    .map((e) => e.libraryItem)
                                    .toList(),
                                isGridView: searchController
                                    .libraryItemsGridViewAuthors,
                                title: "Books (Authors)"),
                            LibraryView<LibraryItem>(
                                items: searchController.results.value.book
                                    .where((element) =>
                                        element.matchKey == "narrators")
                                    .map((e) => e.libraryItem)
                                    .toList(),
                                isGridView: searchController
                                    .libraryItemsGridViewNarrators,
                                title: "Books (Narrators)")
                          ],
                        ),
                  searchController.results.value.authors.isEmpty
                      ? Container()
                      : LibraryView<Author>(
                          items: searchController.results.value.authors,
                          isGridView: searchController.authorsGridView,
                          title: "Authors"),
                ],
              ),
      ),
    );
  }
}
