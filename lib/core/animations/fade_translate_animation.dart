import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget animatedTranslateFade(
    {required Widget child, required Animation animation}) {
  return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Opacity(
          opacity: (1 - animation.value).toDouble(),
          child: Transform.translate(
            offset: Offset(0.0, 30.h * animation.value),
            child: child,
          ),
        );
      });
}

Widget reverseAnimatedTranslateFade(
    {required Widget child, required Animation animation}) {
  return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Opacity(
          opacity: (animation.value).toDouble(),
          child: Transform.translate(
            offset: Offset(0.0, 30.h * (1-animation.value)),
            child: child,
          ),
        );
      });
}
