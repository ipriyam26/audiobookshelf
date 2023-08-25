import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/library_items_response/library_items_result.dart';
import 'package:audiobookshelf/Model/library_response/library.dart';
import 'package:audiobookshelf/Model/recent_series_response/recent_series_response.dart';
import 'package:audiobookshelf/Model/recent_series_response/series.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Library> items = <Library>[].obs;
  final userController = Get.find<UserController>();
  late Rx<Library> dropdownValue;
  RxList<LibraryItem> mediaProgressionItems = <LibraryItem>[].obs;
  RxList<LibraryItem> recentLibraryItems = <LibraryItem>[].obs;
  RxList<Series> recentSeries = <Series>[].obs;
  ApiService apiService = ApiService();
  @override
  onReady() async {
    super.onReady();
    getSortedMediaProgressItem().then((result) {
      if (result != null) {
        mediaProgressionItems.value = result;
      }
    });
    recentLibraryItems.value = await getRecentlyAddedLibraryItems() ?? [];
    recentSeries.value = await getRecentlyAddedSeries() ?? [];
    print(recentSeries);
    update();
  }

  HomeController() {
    dropdownValue = Rx<Library>(userController.libraries[0]);
    items.value = userController.libraries;

    update();
  }

  String getCoverUrl(String libraryItemId) {
    return "${userController.server.value}/api/items/$libraryItemId/cover?token=${userController.currentUser.value.token}";
  }

  String getAuthor(LibraryItem item) {
    try {
      return item.media!.metadata!.authors![0].name!;
    } catch (e) {
      return "Unknown";
    }
  }

  getRecentlyAddedSeries() async {
// var url = Uri.parse('http://192.168.29.207:13378/api/libraries/lib_u4djga7qvsgfoo3txf/series?minified=1&limit=10&sort=addedAt&desc=1');
    final query = {
      'minified': 1,
      'limit': 10,
      'sort': 'addedAt',
      'desc': 1,
    };

    var response = await apiService.authenticatedGet(
        '/api/libraries/${dropdownValue.value.id}/series',
        queryParameters: query);

    final seriesResponse = RecentSeriesResponse.fromMap(response);
    return seriesResponse.results;
  }

  Future<List<LibraryItem>?> getRecentlyAddedLibraryItems() async {
    String libraryId = dropdownValue.value.id!;
    final query = {
      'limit': 20,
      'sort': 'addedAt',
      'minified': 0,
      'desc': 1,
    };
    final response = await apiService.authenticatedGet(
        '/api/libraries/$libraryId/items',
        queryParameters: query);
    final libraryItems = LibraryItemsResult.fromMap(response);

    return libraryItems.results;
  }

  Future<List<LibraryItem>?> getSortedMediaProgressItem() async {
    final mediaProgressionItems = await getMediaProgressItems();
    if (mediaProgressionItems != null) {
      mediaProgressionItems.sort((a, b) {
        final aDate = a.mediaProgress!.lastUpdate ?? 0;
        final bDate = b.mediaProgress!.lastUpdate ?? 0;
        return bDate.compareTo(aDate);
      });
      return mediaProgressionItems;
    }
    return [];
  }

  Future<List<LibraryItem>?> getMediaProgressItems() async {
    final mediaProgressList = userController.currentUser.value.mediaProgress!;
    final mediaProgressMap = {
      for (var e in mediaProgressList) e.libraryItemId!: e
    };

    final mediaProgressLibIds = mediaProgressMap.keys.toList();
    if (mediaProgressLibIds.isNotEmpty) {
      List<LibraryItem>? libItems =
          await userController.getLibraryItemBatch(mediaProgressLibIds);
      if (libItems != null) {
        for (var element in libItems) {
          element.mediaProgress = mediaProgressMap[element.id!];
        }
        return libItems;
      }
    }
    return Future.value([]);
  }
}
