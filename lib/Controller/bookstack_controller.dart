import 'dart:async';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BookStackController extends GetxController {
  var uiImages = <ui.Image>[].obs;
  var loading = true.obs;

  final List<String> images;

  BookStackController(this.images);

  @override
  void onInit() {
    super.onInit();
    _loadImages();
  }

  Future<void> _loadImages() async {
    // Replace with your list of image URLs
    // List<String> images = ["url1", "url2", "url3"];

    for (String imageUrl in images) {
      final Completer<ui.Image> completer = Completer();
      NetworkImage(imageUrl).resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, _) {
          completer.complete(info.image);
        }),
      );
      ui.Image image = await completer.future;
      uiImages.add(image);
    }
    loading.value = false;
  }
}
