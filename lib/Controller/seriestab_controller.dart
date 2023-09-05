import 'package:audiobookshelf/Controller/grouped_controller.dart';
import 'package:audiobookshelf/Model/recent_series_response/recent_series_response.dart';
import 'package:audiobookshelf/Utils/extension.dart';
import 'package:audiobookshelf/Utils/filter.dart';
import 'package:get/get.dart';

class SeriesTabController extends GroupedTabController {
  Rx<SortSeriesItem> sort = SortSeriesItem.addedAt.obs;
  RxBool desc = true.obs;

  void updateSortAndRefresh(SortSeriesItem newSort) {
    sort.value = newSort;
    currentPage = 0;
    pagingController.refresh();
  }

  void updateOrderAndRefresh() {
    desc.value = !desc.value;
    currentPage = 0;
    pagingController.refresh();
  }

  @override
  Future<void> fetchPage(int pageKey) async {
    final queryParams = {
      'limit': pageSize,
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
      final isLastPage = seriesItems!.length < pageSize;
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
}
