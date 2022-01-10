import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final bool isCollapsed;
  final double? screenWidth;
  final Duration duration;
  final Animation<double> scaleAnimation;
  final Function? onMenuTap;
  final Widget? child;

  // ignore: use_key_in_widget_constructors
  const MyDrawer(
      {required this.isCollapsed,
      this.screenWidth,
      required this.duration,
      required this.scaleAnimation,
      this.onMenuTap,
      this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.45 * MediaQuery.of(context).size.width,
        right: isCollapsed ? 0 : -0.35 * MediaQuery.of(context).size.width,
        child: ScaleTransition(
            scale: scaleAnimation,
            child: Material(
              animationDuration: duration,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              elevation: 0,
              child: child,
            )));
  }
}
