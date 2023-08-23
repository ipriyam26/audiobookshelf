import 'package:audiobookshelf/Model/library_response/library.dart';
import 'package:audiobookshelf/Model/library_response/library_response.dart';
import 'package:audiobookshelf/Model/login_response/user.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<User> currentUser = Rx<User>(
      User.empty()); // Assuming 'User' is the class model for user information
  List<Library> libraries = <Library>[].obs;
  void setUser(User user) {
    currentUser.value = user;
    getAllLibraries();
  }

  void clearUser() {
    currentUser.value = User.empty();
  }

  bool get isLoggedIn =>
      currentUser.value.token !=
      null; // or any other logic to check login status

  void getAllLibraries() async {
    ApiService apiService = ApiService();
    // try {
    final response = await apiService.authenticatedGet('api/libraries');
    final libraryResponse = LibraryResponse.fromMap(response);
    if (libraryResponse.libraries != null) {
      libraries = libraryResponse.libraries!;
    }
    print(libraryResponse.toString());
    // } catch (e) {
    //   Get.snackbar("Error", "Error getting libraries");
    // }
  }
}
