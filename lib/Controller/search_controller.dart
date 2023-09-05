import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/search_response/search_response.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';

class SearchItemController extends GetxController {
  ApiService apiService = ApiService();
  RxBool isSearching = false.obs;
  Rx<SearchResponse> results = SearchResponse.empty().obs;
  HomeController homeController = Get.find();
  RxBool isTyping = false.obs;
  RxBool libraryItemsGridViewAuthors = false.obs;
  RxBool libraryItemsGridViewNarrators = false.obs;
  RxBool libraryItemsGridViewTitle = false.obs;
  RxBool authorsGridView = false.obs;
  RxBool seriesGridView = false.obs;

//toggle searching also make results empty and isTyping false
  void toggleSearching() {
    isSearching.value = !isSearching.value;
    results.value = SearchResponse.empty();
    isTyping.value = false;
  }

  Future<SearchResponse> getSearchResults(String query) async {
    isTyping.value = true;
    final queryParameters = {
      'q': query,
    };

    var response = await apiService.authenticatedGet(
      'api/libraries/${homeController.dropdownValue.value.id}/search',
      queryParameters: queryParameters,
    );
    final res = SearchResponse.fromMap(response);
    results.value = res;
    isTyping.value = false;
    return res;
  }
}
