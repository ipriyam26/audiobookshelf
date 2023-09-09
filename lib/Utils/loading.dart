import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: Container(
                height: height,
                width: width + 4.w,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class ShimmerText extends Text {
  @override
  final String text;

  final String placeHolder;
  const ShimmerText(
    this.text, {
    required this.placeHolder,
    Key? key,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) : super(
          text == "" ? placeHolder : text,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );

  @override
  Widget build(BuildContext context) {
    return text == ""
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!.withOpacity(0.2),
            highlightColor: Colors.grey[100]!.withOpacity(0.4),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              color: Colors.white,
              child: super.build(context),
            ),
          )
        : super.build(context);
  }
}
