import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<String> items = <String>['1', '2', '3', '4'].obs;
  // select first item
  late RxString dropdownvalue;

  HomeController() {
    dropdownvalue = items.first.obs;
  }
}
