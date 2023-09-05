import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class GroupedTabController extends GetxController {
  // Common Logic and properties
  var isLoading = false.obs;
  int pageSize = 10;
  int currentPage = 0;
  RxBool isGridView = true.obs;
  HomeController homeController = Get.find();
  UserController userController = Get.find();
  final ApiService apiService = ApiService();

  // Abstract method for fetching data from API
  final PagingController<int, GroupedItems> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onReady() {
    super.onReady();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    ever(homeController.dropdownValue, (_) {
      // Reset and refresh when dropdownValue changes
      currentPage = 0;
      pagingController.refresh();
    });
  }

  Future<void> fetchPage(int pageKey);

  // Common implementation for shared logic
  List<String> getCoverUrl(GroupedItems item) {
    return item.books.map((e) => homeController.getCoverUrl(e.id)).toList();
  }
}
