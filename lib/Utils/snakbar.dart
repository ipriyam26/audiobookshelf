import 'package:flutter/material.dart';
import 'package:get/get.dart';

void getErrorSnackbar(String title, String message, ThemeData theme) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.error_outline),
      backgroundColor: theme.colorScheme.error,
      colorText: theme.textTheme.bodyLarge!.color!);
}
