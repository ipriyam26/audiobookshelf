import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';

class LibraryItemController extends GetxController {
  Rx<LibraryItem> item = LibraryItem.empty().obs;

  LibraryItemController(LibraryItem libraryItem) {
    item.value = libraryItem;
  }
  ApiService apiService = ApiService();
  @override
  Future<void> onReady() async {
    super.onReady();
    print("Making request: ${item.value.id}");
    final params = {"expanded": "true", "include": "progress"};
    final response = await apiService.authenticatedGet(
        "api/items/${item.value.id}",
        queryParameters: params);
    item.value = LibraryItem.fromMap(response);
    print("Making Another request: ${item.value.title}");
    update();
  }

  final UserController userController = Get.find<UserController>();

  String getAudioFileNames(int index) {
    return item.value.audioFiles[index].metadata!.filename ?? "Failed to Load";
  }

  String getChapterNames(int index) {
    return item.value.chapterList[index].title ?? "Failed to Load";
  }

  String getCoverUrl() {
    return item.value.getCoverUrl(
        userController.server.value, userController.currentUser.value.token!,
        raw: true);
  }

  Map<String, int> convertToHours(int totalSeconds) {
    final int hours = totalSeconds ~/ 3600;
    final int minutes = (totalSeconds % 3600) ~/ 60;
    final int seconds = totalSeconds % 60;
    return {'hours': hours, 'minutes': minutes, 'seconds': seconds};
  }

  String getLeftOverTime() {
    try {
      final double leftTime =
          item.value.media.duration! - item.value.mediaProgress!.currentTime!;
      final int totalSeconds =
          leftTime.floor(); // Convert to nearest lower integer

      final int hours = totalSeconds ~/ 3600;
      final int minutes = (totalSeconds % 3600) ~/ 60;

      return '$hours hr $minutes min  sec left';
    } catch (e) {
      return "Not able to process";
    }
  }

  String getChapterDuration(
    double start,
  ) {
    try {
      final time = convertToHours(start.toInt());
      final hour = time["hours"]!;
      final minutes = time["minutes"]!;
      final seconds = time["seconds"]!;
      String chaptertime = hour < 10 ? "0$hour" : "$hour";
      chaptertime += ":${minutes < 10 ? "0$minutes" : "$minutes"}";
      chaptertime += ":${seconds < 10 ? "0$seconds" : "$seconds"}";
      return chaptertime;
    } catch (e) {
      return "Not able to process";
    }
  }
}
