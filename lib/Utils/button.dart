import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextOutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const TextOutlineButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
          width: 1.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.h, vertical: 8.h),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleLarge!, // Adjust this to match your theme's text style
        ),
      ),
    );
  }
}
