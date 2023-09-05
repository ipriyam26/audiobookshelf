import 'package:audiobookshelf/Controller/grouped_controller.dart';
import 'package:audiobookshelf/Model/collection_response/collection_response.dart';

class CollectionTabController extends GroupedTabController {
  @override
  Future<void> fetchPage(int pageKey) async {
    final queryParams = {
      'limit': pageSize,
      'page': currentPage,
      'minified': 0,
    };

    try {
      var response = await apiService.authenticatedGet(
          'api/libraries/${homeController.dropdownValue.value.id}/collections',
          queryParameters: queryParams);
      final collectionItems = CollectionResponse.fromMap(response).results;
      final isLastPage = collectionItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(collectionItems);
      } else {
        final nextPageKey = pageKey + collectionItems.length;
        currentPage = nextPageKey;
        pagingController.appendPage(collectionItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
