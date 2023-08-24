import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/library_items_response/library_items_response.dart';
import 'package:audiobookshelf/Model/library_response/library.dart';
import 'package:audiobookshelf/Model/library_response/library_response.dart';
import 'package:audiobookshelf/Model/login_response/login_response.dart';
import 'package:audiobookshelf/Model/login_response/user.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<User> currentUser = Rx<User>(User.empty());
  RxString server = "".obs;
  List<Library> libraries = <Library>[].obs;
  Rx<LoginResponse> loginResponse = Rx<LoginResponse>(LoginResponse.empty());
  Future<void> setUser(User user) async {
    currentUser.value = user;
    // print("User progressions: ${user.mediaProgress}");
    await getAllLibraries();
  }

  setServer(String value) {
    server.value = value;
  }

  void clearUser() {
    currentUser.value = User.empty();
  }

  void setLoginResponse(LoginResponse loginResponse) {
    this.loginResponse.value = loginResponse;
  }

  bool get isLoggedIn =>
      currentUser.value.token !=
      null; // or any other logic to check login status

  Future<void> getAllLibraries() async {
    ApiService apiService = ApiService();
    try {
      final response = await apiService.authenticatedGet('api/libraries');
      final libraryResponse = LibraryResponse.fromMap(response);
      if (libraryResponse.libraries != null) {
        libraries = libraryResponse.libraries!;
        // print("Libraries: ${libraries.map((e) => e.name)}");
      }
    } catch (e) {
      Get.snackbar("Error", "Error getting libraries");
    }
  }

  Future<List<LibraryItem>?> getLibraryItemBatch(List<String> ids) async {
    ApiService apiService = ApiService();
    // try {
    final response = await apiService
        .authenticatedPost('api/items/batch/get', {"libraryItemIds": ids});
    final libraryItemResponse = LibraryItemsResponse.fromMap(response);
    if (libraryItemResponse.libraryItems != null) {
      return libraryItemResponse.libraryItems!;
    }
    // } catch (e) {
    //   Get.snackbar("Error", "Error getting library items");
    // }
    return [];
  }
}
