import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextOutlineButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isDisabled;

  const TextOutlineButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return isDisabled
        ? OutlinedButton(
            onPressed: null,
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
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ), // Adjust this to match your theme's text style
              ),
            ),
          )
        : OutlinedButton(
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

class OptionIconButton extends StatelessWidget {
  const OptionIconButton({
    super.key,
    this.onPressed,
    required this.icon,
  });
  final void Function()? onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 36.h,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 27, 27, 27),
        border: Border.all(color: Colors.white, width: 0.2.w),
        borderRadius: BorderRadius.circular(4.w),
      ),
      child: IconButton(
          padding: EdgeInsets.zero,
          // alignment: Alignment.bottomCenter,
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 28.w,
          )),
    );
  }
}
