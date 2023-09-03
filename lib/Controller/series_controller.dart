import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/collection_response/group_item.dart';
import 'package:get/get.dart';

class SeriesController extends GetxController {
  final GroupedItems item;
  SeriesController({required this.item});
  final UserController userController = Get.find<UserController>();
  String getCoverUrl(int index) {
    return item.books[index].getCoverUrl(
      userController.server.value,
      userController.currentUser.value.token!,
    );
  }
}
