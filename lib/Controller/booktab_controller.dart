import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/library_items_response/library_items_result.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BookTabController extends GetxController {
  var items = <LibraryItem>[].obs;
  var isLoading = false.obs;
  final _pageSize = 20;
  int currentPage = 0;
  final ApiService apiService = ApiService();
  final PagingController<int, LibraryItem> pagingController =
      PagingController(firstPageKey: 0);
  @override
  void onReady() {
    super.onReady();
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    // fetchMoreItems();
  }

  HomeController homeController = Get.find();
  UserController userController = Get.find();
  Future<void> _fetchPage(int pageKey) async {
    final queryParams = {
      'limit': _pageSize,
      'page': currentPage,
      'minified': 0,
      'sort': 'updatedAt',
      'desc': 1,
    };

    try {
      final newItems = await apiService.authenticatedGet(
          "/api/libraries/${homeController.dropdownValue.value.id}/items",
          queryParameters: queryParams);
      final libraryResponse = LibraryItemsResult.fromMap(newItems);
      final libraryItems = libraryResponse.results;
      final isLastPage = libraryItems!.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(libraryItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        currentPage += 1;
        pagingController.appendPage(libraryItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  String getCoverUrl(LibraryItem item) {
    return item.getCoverUrl(
        userController.server.value, userController.currentUser.value.token!);
  }
}
