import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item_with_progress.dart';
import 'package:audiobookshelf/Model/library_response/library.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Library> items = <Library>[].obs;
  // select first item
  final userController = Get.find<UserController>();
  late Rx<Library> dropdownvalue;
  // late RxString coverUrl;
  RxList<LibraryItemWithProgress> mediaProgressionItems =
      <LibraryItemWithProgress>[].obs;
  HomeController() {
    dropdownvalue = Rx<Library>(userController.libraries[0]);
    items.value = userController.libraries;
    getSortedMediaProgressItem().then((result) {
      if (result != null) {
        mediaProgressionItems.value = result;
      }
    });
    // coverUrl =

    //         .obs;
    update();
  }

  String getCoverUrl(String libraryItemId) {
    return "${userController.server.value}/api/items/$libraryItemId/cover?token=${userController.currentUser.value.token}";
  }

  String getAuthor(int idx) {
    try {
      return mediaProgressionItems[idx].media!.metadata!.authors![0].name!;
    } catch (e) {
      return "Unknown";
    }
  }

  Future<List<LibraryItemWithProgress>?> getSortedMediaProgressItem() async {
    final mediaProgressionItems = await getMediaProgressItems();
    if (mediaProgressionItems != null) {
      mediaProgressionItems.sort((a, b) {
        final aDate = a.mediaProgress.lastUpdate ?? 0;
        final bDate = b.mediaProgress.lastUpdate ?? 0;
        return bDate.compareTo(aDate);
      });
      return mediaProgressionItems;
    }
    return [];
  }

  Future<List<LibraryItemWithProgress>?> getMediaProgressItems() async {
    final mediaProgressList = userController.currentUser.value.mediaProgress!;
    final mediaProgressMap = {
      for (var e in mediaProgressList) e.libraryItemId!: e
    };

    ApiService apiService = ApiService();
    final mediaProgressLibIds = mediaProgressMap.keys.toList();
    if (mediaProgressLibIds.isNotEmpty) {
      List<LibraryItem>? libItems =
          await userController.getLibraryItemBatch(mediaProgressLibIds);
      if (libItems != null) {
        return libItems.map((libItem) {
          // print(apiService.authenticatedGet("/api/items/${libItem.id}/cover"));
          // return `${rootState.routerBasePath}/api/items/${libraryItemId}/cover?token=${userToken}${raw ? '&raw=1' : ''}${timestamp ? `&ts=${timestamp}` : ''}`
          return LibraryItemWithProgress(
            libraryItem: libItem,
            mediaProgress: mediaProgressMap[libItem.id]!,
          );
        }).toList();
      }
    }
    return Future.value([]);
  }
}
