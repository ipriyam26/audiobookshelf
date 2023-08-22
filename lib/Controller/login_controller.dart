import 'package:audiobookshelf/Services/api_service.dart';
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
    // make a get request and if theme is an error show using get snackbar
  }

  Future<void> login() async {
    // make a post request and if theme is an error show using get snackbar
  }
}
