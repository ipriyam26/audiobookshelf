import 'dart:convert';
import 'dart:io';

import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class LibraryItemController extends GetxController {
  Rx<LibraryItem> item = LibraryItem.empty().obs;
  final UserController userController = Get.find<UserController>();

  LibraryItemController(LibraryItem libraryItem) {
    item.value = libraryItem;
  }
  ApiService apiService = ApiService();
  @override
  Future<void> onReady() async {
    super.onReady();
    item.value = await getLibraryItem();

    update();
  }

  Future<LibraryItem> getLibraryItem() async {
    final params = {"expanded": "true", "include": "progress"};
    final response = await apiService.authenticatedGet(
        "api/items/${item.value.id}",
        queryParameters: params);
    return LibraryItem.fromMap(response);
  }

  startPlaybackSession() async {
    final response = await apiService.authenticatedPost(
      "api/items/${item.value.id}/play",
      {
        "deviceInfo": {"clientVersion": "0.0.1"},
        "supportedMimeTypes": ["audio/flac", "audio/mpeg", "audio/mp4"]
      },
    );
    //save response as a file
    // File file = File("${item.value.id}.json");
    Directory tempDir = await getTemporaryDirectory();
    //delete files if exists

    File file = File('${tempDir.path}/${item.value.id}.json');
    String jsonString = jsonEncode(response);
    print(item.value.id);
    file.writeAsString(jsonString);
    if (kDebugMode) {
      print(file.path);
      print(response);
    }
  }

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
