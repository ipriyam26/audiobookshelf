import 'package:audiobookshelf/Utils/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookStack extends StatelessWidget {
  // Add paths to your book images
  final List<String> images;
  final double scaleFactor;
  const BookStack({super.key, required this.images, this.scaleFactor = 1});

  @override
  Widget build(BuildContext context) {
    final clappedBooks = images.clamp(10);
    double width = 320.w * scaleFactor;
    double height = 140.h * scaleFactor;
    double individualWidth = 170.w * scaleFactor;
    double overlap = clappedBooks.length > 1
        ? (width - height) / (clappedBooks.length - 1)
        : 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4.w),
      child: SizedBox(
        height: height,
        width: width,
        child: clappedBooks.length == 1
            ? CachedNetworkImage(
                imageUrl: clappedBooks.first,
                fit: BoxFit.cover,
              )
            : Stack(
                children: [
                  for (int i = 0; i < clappedBooks.length; i++)
                    Positioned(
                      left: i * overlap,
                      child: CachedNetworkImage(
                        imageUrl: clappedBooks[i],
                        height: height,
                        width: individualWidth,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => Container(
                          height: height,
                          width: individualWidth,
                          color: Colors.white,
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/book_placeholder.jpg",
                          height: height,
                          width: individualWidth,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
