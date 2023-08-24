import 'package:audiobookshelf/Controller/login_controller.dart';
import 'package:audiobookshelf/Utils/button.dart';
import 'package:audiobookshelf/Utils/textfield.dart';
import 'package:audiobookshelf/View/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
// get put controller
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SizedBox(
          height: 520.h,

          // alignment: Alignment.,
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    child: PageTransitionSwitcher(
                        duration: const Duration(milliseconds: 500),
                        // reverse: true,
                        transitionBuilder:
                            (child, animation, secondaryAnimation) {
                          return SharedAxisTransition(
                            animation: animation,
                            secondaryAnimation: secondaryAnimation,
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                        child: controller.addingUser.value
                            ? AddUser()
                            : AddServer()),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100.h),
                    child: controller.isLoading.value
                        ? SpinKitDoubleBounce(
                            color: Theme.of(context).colorScheme.primary,
                            // waveColor: Theme.of(context).colorScheme.secondary,
                            duration: const Duration(milliseconds: 2000),
                            size: 48.h,
                          )
                        : Container(height: 48.h),
                  )
                ],
              )),
        ));
  }
}

class AddServer extends StatelessWidget {
  AddServer({
    super.key,
  });
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).colorScheme.shadow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        size: 16.h,
                        color: Theme.of(context).colorScheme.outline,
                      )),
                  Text(
                    "Server Address",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Container(
                    width: 16.h,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.h),
                child: Obx(() => OutlineTextField(
                      hintText: "http://55.55.55.55:13378",
                      controller: controller.serverController,
                      isDisabled: controller.isLoading.value,
                    )),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextOutlineButton(
                        text: "Submit",
                        onPressed: () async {
                          await controller.pingServer();
                          controller.toggleSubmit();
                          // move to home screen
                        },
                        isDisabled: controller.isLoading.value,
                      ),
                    ],
                  ))
            ],
          ),
        ));
  }
}

class AddUser extends StatelessWidget {
  AddUser({super.key});
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          controller.toggleSubmit();
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          size: 16.h,
                          color: Theme.of(context).colorScheme.outline,
                        )),
                    Text(
                      "Add User",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Container(
                      width: 16.w,
                    )
                  ],
                ),
                Container(
                  height: 96.h,
                  margin: EdgeInsets.symmetric(vertical: 16.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineTextField(
                        hintText: "Username",
                        controller: controller.usernameController,
                        isDisabled: controller.isLoading.value,
                      ),
                      ProtectedOutlineTextField(
                        hintText: "Password",
                        controller: controller.passwordController,
                        isDisabled: controller.isLoading.value,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextOutlineButton(
                        text: "Submit",
                        onPressed: () async {
                          await controller.login();
                          Get.offAll(HomeScreen());
                        },
                        isDisabled: controller.isLoading.value)
                  ],
                )
              ],
            )),
      ),
    );
  }
}
