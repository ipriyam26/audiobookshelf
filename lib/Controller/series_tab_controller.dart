import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/recent_series_response.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:audiobookshelf/Utils/filter.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SeriesTabController extends GetxController {
  var isLoading = false.obs;
  final _pageSize = 10;
  int currentPage = 0;
  RxBool isGridView = true.obs;

  Rx<SortSeriesItem> sort = SortSeriesItem.addedAt.obs;
  RxBool desc = true.obs;
  final ApiService apiService = ApiService();
  final PagingController<int, Series> pagingController =
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

  void updateSortAndRefresh(SortSeriesItem newSort) {
    sort.value = newSort; // Update the sort variable
    currentPage = 0; // Reset the pagination counter
    pagingController.refresh(); // Clear the existing items and refresh
  }

  void updateOrderAndRefresh() {
    desc.value = !desc.value; // Update the sort variable
    currentPage = 0; // Reset the pagination counter
    pagingController.refresh(); // Clear the existing items and refresh
  }

  Future<void> _fetchPage(int pageKey) async {
    final queryParams = {
      'limit': _pageSize,
      'page': currentPage,
      'minified': 0,
      'sort': sort.value.query,
      'desc': desc.value ? 1 : 0,
    };

    try {
      var response = await apiService.authenticatedGet(
          '/api/libraries/${homeController.dropdownValue.value.id}/series',
          queryParameters: queryParams);

      final seriesResponse = RecentSeriesResponse.fromMap(response);
      final seriesItems = seriesResponse.results;
      final isLastPage = seriesItems!.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(seriesItems);
      } else {
        final nextPageKey = pageKey + seriesItems.length;
        currentPage += 1;
        pagingController.appendPage(seriesItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  // String getCoverUrl(LibraryItem item) {
  //   return item.getCoverUrl(
  //       userController.server.value, userController.currentUser.value.token!);
  // }
}
