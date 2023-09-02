
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
    double width = 320.w * scaleFactor;
    double height = 140.h * scaleFactor;
    double individualWidth = 170.w * scaleFactor;
    double overlap =
        images.length > 1 ? (width - height) / (images.length - 1) : 0;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      height: height,
      width: width,
      child: Card(
        elevation: 10,
        child: images.length == 1
            ? CachedNetworkImage(
                imageUrl: images.first,
                fit: BoxFit.cover,
              )
            : Stack(
                children: [
                  for (int i = 0; i < images.length; i++)
                    Positioned(
                      left: i * overlap,
                      child: CachedNetworkImage(
                        imageUrl: images[i],
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

        // margin: EdgeInsets.symmetric(horizontal: 10.w),
      ),
    );
  }
}


// class BookStack extends StatefulWidget {
//   final List<String> images;
//   final double scaleFactor;

//   const BookStack({
//     Key? key,
//     required this.images,
//     this.scaleFactor = 1,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _BookStackState createState() => _BookStackState();
// }

// class _BookStackState extends State<BookStack> {
//   List<ui.Image> uiImages = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadImages();
//   }

//   Future<void> _loadImages() async {
//     for (String imageUrl in widget.images) {
//       final Completer<ui.Image> completer = Completer();
//       NetworkImage(imageUrl)
//           .resolve(const ImageConfiguration())
//           .addListener(ImageStreamListener((ImageInfo info, _) {
//         completer.complete(info.image);
//       }));
//       ui.Image image = await completer.future;
//       uiImages.add(image);
//     }

//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (loading) {
//       return const CircularProgressIndicator();
//     }

//     return RepaintBoundary(
//       child: CustomPaint(
//         size: Size(320 * widget.scaleFactor, 140 * widget.scaleFactor),
//         painter: BookStackPainter(uiImages),
//       ),
//     );
//   }
// }

// class BookStackPainter extends CustomPainter {
//   final List<ui.Image> images;

//   BookStackPainter(this.images);

//   @override
//   void paint(Canvas canvas, Size size) {
//     double overlap = images.length > 1
//         ? (size.width - size.height) / (images.length - 1)
//         : 0;

//     for (int i = 0; i < images.length; i++) {
//       final img = images[i];
//       final imgRatio = img.width / img.height;
//       final imgHeight = size.height;
//       final imgWidth = size.height * imgRatio;
//       final srcRect = Rect.fromPoints(
//           Offset(0, 0), Offset(img.width.toDouble(), img.height.toDouble()));
//       final dstRect = Rect.fromPoints(
//         Offset(i * overlap, 0),
//         Offset(i * overlap + imgWidth, imgHeight),
//       );

//       canvas.drawImageRect(img, srcRect, dstRect, Paint());
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
