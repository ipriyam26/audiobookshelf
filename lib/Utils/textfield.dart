import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OutlineTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isDisabled;

  const OutlineTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: !isDisabled,
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

class ProtectedOutlineTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isDisabled;

  const ProtectedOutlineTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isDisabled,
  });

  @override
  State<ProtectedOutlineTextField> createState() =>
      _ProtectedOutlineTextFieldState();
}

class _ProtectedOutlineTextFieldState extends State<ProtectedOutlineTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: !widget.isDisabled,
      obscureText: isHidden,
      controller:
          widget.controller, // Assigning the passed TextEditingController
      style: Theme.of(context).textTheme.titleLarge,
      decoration: InputDecoration(
        suffixIcon: isHidden // If it's a password field, add the eye icon
            ? IconButton(
                icon: const Icon(
                  Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden; // Toggle between showing/hiding text
                  });
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden; // Toggle between showing/hiding text
                  });
                },
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
        hintText: widget.hintText, // Using the passed hintText
      ),
    );
  }
}
