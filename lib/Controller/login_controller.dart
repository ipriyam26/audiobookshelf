import 'package:audiobookshelf/Model/login_response/login_response.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool addingUser = false.obs;
  RxBool isLoading = false.obs;
  // make three text edit controller for server, username and password
  TextEditingController serverController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void toggleSubmit() {
    addingUser.value = !addingUser.value; // This line toggles the value
  }

  Future<void> pingServer() async {
    isLoading.value = true;
    ApiService apiService = ApiService(
        serverUrl: serverController.text, theme: Theme.of(Get.context!));
    try {
      final response = await apiService.get('ping');
      if (!response["success"]) {
        // Get.snackbar("Success", "Server is up and running");
        Get.snackbar("Error", "Server is not running");
      }
    } catch (e) {
      Get.snackbar("Error", "Server is not running");
    }

    isLoading.value = false;
  }

  Future<void> login() async {
    isLoading.value = true;
    ApiService apiService = ApiService(
        serverUrl: serverController.text, theme: Theme.of(Get.context!));
    // try {
      final response = await apiService.post('login', {
        "username": usernameController.text,
        "password": passwordController.text
      });
      print(response);
      final loginResponse = LoginResponse.fromMap(response);
      if (kDebugMode) {
        print(loginResponse.user!.token);
      }
      if (loginResponse.user!.token != null) {
        Get.snackbar("Success", "Login Successful");
      }
    // } catch (e) {
    //   Get.snackbar("Error", "Login Failed");
    // }
    isLoading.value = false;
  }
}
