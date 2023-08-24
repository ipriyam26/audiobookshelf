import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/Model/login_response/login_response.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    ApiService apiService = ApiService.initialize(
        serverUrl: serverController.text, theme: Get.theme);
    try {
      final response = await apiService.get('ping');
      if (!response["success"]) {
        // Get.snackbar("Success", "Server is up and running");
        Get.snackbar("Error", "Not able to ping server");
      }
    } catch (e) {
      Get.snackbar("Error", "Internal Server Error");
    }

    isLoading.value = false;
  }

  Future<bool> login() async {
    isLoading.value = true;
    final username = usernameController.text;
    final password = passwordController.text;

    ApiService apiService = ApiService();
    try {
      final response = await apiService.post('login', {
        "username": username,
        "password": password,
      });
      final loginResponse = LoginResponse.fromMap(response);
      final userController = Get.find<UserController>();
      if (loginResponse.user!.token != null) {
        ApiService().setAuthToken(loginResponse.user!.token!);
        await userController.setUser(loginResponse.user!);
        await userController.setServer(serverController.text);
        userController.setLoginResponse(loginResponse);
        Get.snackbar("Success", "Login Successful");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("server", serverController.text);
        await prefs.setString("username", usernameController.text);
        await prefs.setString("password", passwordController.text);
        await prefs.setString("token", loginResponse.user!.token!);
      } else {
        throw Exception("Login Failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Login Failed");
      isLoading.value = false;
      return false;
    }
    isLoading.value = false;
    return true;
  }
}
