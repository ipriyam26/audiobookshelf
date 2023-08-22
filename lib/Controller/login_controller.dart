import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool addingUser = false.obs;
  toggleSubmit() {
    addingUser.value = !addingUser.value; // This line toggles the value

  }
}
