import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/login_response/login_response.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  Future<bool> automaticLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final server = prefs.getString("server");
    final username = prefs.getString("username");
    final password = prefs.getString("password");
    if (server == null || username == null || password == null) {
      return false;
    }

    ApiService apiService =
        ApiService.initialize(serverUrl: server, theme: Get.theme);
    try {
      final response = await apiService.post('login', {
        "username": username,
        "password": password,
      });
      final loginResponse = LoginResponse.fromMap(response);
      final userController = Get.find<UserController>();
      userController.setServer(server);
      if (loginResponse.user!.token != null) {
        ApiService().setAuthToken(loginResponse.user!.token!);
        await userController.setUser(loginResponse.user!);
        userController.setLoginResponse(loginResponse);
        return true;
      } else {
        throw Exception("Login Failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Login Failed");
      return false;
    }
  }
}
