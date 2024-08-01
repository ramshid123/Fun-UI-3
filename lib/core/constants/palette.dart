import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class ColorConstants {
  final Color textColor = const Color(0xff000000);
  final Color mediumColor = Colors.black.withOpacity(0.7);
  final Color liteColor = Colors.black.withOpacity(0.4);
  final Color iconColor = Colors.black.withOpacity(0.4);
  final Color backgroundColor = const Color.fromARGB(255, 225, 225, 227);
  final Color containreColor = const Color(0xffffffff);
  final Icon colorModeIcon = Icon(
    Icons.sunny,
    color: const Color(0xffffffff),
    size: 30.r,
  );
}

class ColorConstantsLight extends ColorConstants {
  @override
  Color get textColor => const Color(0xff000000);
  @override
  Color get mediumColor => Colors.black.withOpacity(0.7);
  @override
  Color get liteColor => Colors.black.withOpacity(0.4);
  @override
  Color get iconColor => Colors.black.withOpacity(0.4);
  @override
  Color get backgroundColor => const Color.fromARGB(255, 225, 225, 227);
  @override
  Color get containreColor => const Color(0xffffffff);
  @override
  Icon get colorModeIcon => Icon(
        Icons.sunny,
        color: const Color(0xffffffff),
        size: 30.r,
      );
}

class ColorConstantsDark extends ColorConstants {
  @override
  Color get textColor => const Color(0xffffffff);
  @override
  Color get mediumColor => Colors.white.withOpacity(0.7);
  @override
  Color get liteColor => Colors.white.withOpacity(0.4);
  @override
  Color get iconColor => Colors.white.withOpacity(0.4);
  @override
  Color get backgroundColor => const Color.fromARGB(255, 37, 37, 37);
  @override
  Color get containreColor => const Color.fromARGB(255, 19, 19, 19);
  @override
  Icon get colorModeIcon => Icon(
        Icons.dark_mode,
        color: const Color(0xff000000),
        size: 30.r,
      );
}
