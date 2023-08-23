import 'dart:convert';

import 'package:audiobookshelf/Controller/auth_controller.dart';
import 'package:audiobookshelf/Controller/user_controller.dart';
import 'package:audiobookshelf/View/home.dart';
import 'package:audiobookshelf/View/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:json_theme/json_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeData theme = await getTheme();
  Get.put(UserController());
  final authController = Get.put(AuthController());
  final canAutoLogin = await authController.automaticLogin();
  if (kDebugMode) {
    print("canAutoLogin: $canAutoLogin");
  }
  final initialScreen = canAutoLogin ? HomeScreen() : LoginScreen();

  runApp(MyApp(theme: theme, initialScreen: initialScreen));
}

Future<ThemeData> getTheme() async {
  final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  final themeJson = await jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  return theme;
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final Widget initialScreen;
  const MyApp({Key? key, required this.theme, required this.initialScreen})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: theme,
          home: initialScreen,
        );
      },
    );
  }
}
