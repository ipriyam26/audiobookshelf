import 'package:audiobookshelf/Controller/player_controller.dart';
import 'package:audiobookshelf/Model/library_items_response/library_item.dart';
import 'package:audiobookshelf/Model/playback_session/playback_session.dart';
import 'package:audiobookshelf/Utils/loading.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Player extends StatelessWidget {
  const Player({
    super.key,
    required this.item,
  });
  final LibraryItem item;

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController =
        Get.put(PlayerController(item: item));

    return Scaffold(
        body: Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ...playerController.gradientColors,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 24.h,
                      )),
                  Text(
                    playerController
                        .playbackSessionManager.value.session.playMethod.label,
                    style: Get.textTheme.bodyLarge,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        size: 24.h,
                      ))
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      playerController.getPallett(imageProvider);
                      return Container(
                        // height: Get.height * 0.4,
                        // width: Get.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(12.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ]),
                      );
                    },
                    imageUrl: playerController.coverUrl,
                    height: Get.height * 0.45,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: Get.height * 0.4,
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/book_placeholder.jpg",
                      height: Get.height * 0.4,
                      width: Get.width,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerText(
                              playerController.currentChapterTitle,
                              placeHolder: "Chapter 32",
                              style: Get.textTheme.headlineMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            ShimmerText(
                              playerController.playbackSessionManager.value
                                  .session.libraryItem.authorName,
                              placeHolder: "Matt Dinimain,Jeff Heys",
                              style: Get.textTheme.headlineSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() => Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      // playerController.position.value
                                      playerController
                                          .position.value.formatDuration,
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                    const Spacer(),
                                    Text(
                                      playerController
                                          .duration.value.formatDuration,
                                      style: Get.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                                Slider(
                                  onChanged: playerController.onChange,
                                  value: (playerController
                                              .position.value.inSeconds /
                                          (playerController
                                                  .duration.value.inSeconds
                                                  .toDouble() +
                                              1))
                                      .clamp(0, 1),
                                ),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: playerController.previousChapter,
                              icon: Icon(
                                Icons.skip_previous,
                                size: 32.h,
                              ),
                            ),
                            Obx(
                              () => IconButton(
                                onPressed: () {
                                  if (playerController.playerState.value ==
                                      PlayerState.playing) {
                                    playerController.pause();
                                  } else {
                                    playerController.play();
                                  }
                                },
                                icon: Icon(
                                  playerController.playerState.value ==
                                          PlayerState.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 32.h,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: playerController.nextChapter,
                                icon: Icon(
                                  Icons.skip_next,
                                  size: 32.h,
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    ));
  }
}
