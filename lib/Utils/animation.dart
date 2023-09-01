import 'package:flutter/material.dart';

class IconAnimation extends StatelessWidget {
  const IconAnimation({super.key, required this.condition});
  final bool condition;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          //rotation animation
          return RotationTransition(turns: animation, child: child);
        },
        duration: const Duration(milliseconds: 400),
        child: condition
            ? Icon(key: UniqueKey(), Icons.swap_horiz_rounded)
            : Icon(key: UniqueKey(), Icons.grid_on));
  }
}

class ListToGridAnimation extends StatelessWidget {
  const ListToGridAnimation({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return SlideTransition(
              //horizontal slide
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(animation),
              child: child);
        },
        duration: const Duration(milliseconds: 400),
        child: child);
  }
}
