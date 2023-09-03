import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
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
  RxList<Author> recentAuthors = <Author>[].obs;
  ApiService apiService = ApiService();
  RxBool continueListeningGridView = false.obs;
  RxBool recentLibraryItemsGridView = false.obs;
  RxBool recentSeriesGridView = false.obs;
  RxBool recentAuthorsGridView = false.obs;

  @override
  onReady() async {
    super.onReady();
    mediaProgressionItems.value = await getSortedMediaProgressItem() ?? [];
    recentLibraryItems.value = await getRecentlyAddedLibraryItems() ?? [];
    recentSeries.value = await getRecentlyAddedSeries() ?? [];
    recentAuthors.value = await getRecentAuthors() ?? [];
    print("All initialized");
    update();
  }

  HomeController() {
    dropdownValue = Rx<Library>(userController.libraries.first);
    items.value = userController.libraries;

    update();
  }

  String getAuthorUrl(String authorID, int? updatedAt) {
    return "${userController.server.value}/api/authors/$authorID/image?token=${userController.currentUser.value.token}";
  }

  String getCoverUrl(String libraryItemId) {
    return "${userController.server.value}/api/items/$libraryItemId/cover?token=${userController.currentUser.value.token}";
  }

  Future<List<Author>?> getRecentAuthors() async {
    var authors = [];
    for (var items in recentLibraryItems) {
      var localAuthors =
          items.media.metadata.authors!.map((author) => author.id);
      authors.addAll(localAuthors);
    }
    authors = authors.toSet().toList();
    List<Author> fAuthor = [];
    var param = {
      'include': 'items,series',
    };
    for (var author in authors) {
      var response = await apiService.authenticatedGet("/api/authors/$author",
          queryParameters: param);
      final tAuthor = Author.fromMap(response);
      print("request made: /api/authors/$author");
      print("Recieved author ${tAuthor.name}");
      fAuthor.add(tAuthor);
    }
    // print(fAuthor);
    return fAuthor;
  }

  String getAuthor(LibraryItem item) {
    try {
      return item.media.metadata.authors![0].name!;
    } catch (e) {
      return "Unknown";
    }
  }

  Future<List<Series>?> getRecentlyAddedSeries() async {
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
          element.mediaProgress = mediaProgressMap[element.id];
        }
        return libItems;
      }
    }
    return Future.value([]);
  }
}
