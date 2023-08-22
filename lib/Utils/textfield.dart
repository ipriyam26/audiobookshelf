import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const OutlineTextField({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Assigning the passed TextEditingController
      style: Theme.of(context).textTheme.titleLarge,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.outline,
        ),
        hintText: hintText, // Using the passed hintText
      ),
    );
  }
}
