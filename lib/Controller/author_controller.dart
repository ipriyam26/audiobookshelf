import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthorController extends GetxController {
  Rx<Author> item = Author.empty().obs;
  RxList<Series> series = <Series>[].obs;
  ApiService apiService = ApiService();
  RxBool bookGridView = false.obs;
  RxBool seriesGridView = false.obs;

  AuthorController(Author author) {
    item.value = author;
  }
  UserController userController = Get.find();
  String getAuthorImageUrl() {
    return item.value.getAuthorUrl(
        userController.server.value, userController.currentUser.value.token!);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    item.value = await getAuthor();

    series.value = await getSeries() ?? [];
  }

  Future<Author> getAuthor() async {
    final query = {
      'include': 'items,series',
    };
    try {
      final response = await apiService.authenticatedGet(
          'api/authors/${item.value.id}',
          queryParameters: query);
      final author = Author.fromMap(response);
      return author;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching author know as ${item.value.name}");
        print("Request was api/authors/${item.value.id}");
        print(e);
      }
      return Author.empty();
    }
  }

  Future<List<Series>?> getSeries() async {
    final query = {'include': 'progress'};
    // List<String> seriesIds = [];
    List<Series> series = [];
    for (Series seriesItem in item.value.series) {
      try {
        var response = await apiService.authenticatedGet(
            'api/series/${seriesItem.id}',
            queryParameters: query);
        final List<dynamic> tempSeriesIds =
            response['progress']['libraryItemIds'];
        final List<String> seriesIds =
            tempSeriesIds.map((e) => e.toString()).toList();

        List<LibraryItem>? libraryItems =
            await userController.getLibraryItemBatch(
                seriesIds); // Get the library items from the ids
        Series newSeries = seriesItem.copyWith(books: libraryItems);
        series.add(newSeries);
      } catch (e) {
        if (kDebugMode) {
          print("Error fetching series know as ${seriesItem.name}");
          print(e);
        }
        continue;
      }
    }
    return series;
  }
}
