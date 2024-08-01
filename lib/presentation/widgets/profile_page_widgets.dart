
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_project/core/constants/palette.dart';
import 'package:fun_project/core/widgets/common.dart';

class ProfilePageWidgets {
  static Widget additionalSection({
    required ColorConstants colors,
  }) {
    return _AdditionalSection(colors: colors);
  }

  static Widget _navigationButtons({
    required Icon icon,
    required double height,
    required ColorConstants colors,
    required Animation animation,
    required String text,
  }) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(0.0, height * animation.value),
            child: Row(
              children: [
                icon,
                kWidth(20.w),
                kText(
                  text,
                  color: colors.mediumColor,
                  fontSize: 17,
                ),
                const Spacer(),
                Icon(
                  Icons.navigate_next,
                  color: colors.iconColor,
                ),
              ],
            ),
          );
        });
  }
}

class _AdditionalSection extends StatefulWidget {
  final ColorConstants colors;
  const _AdditionalSection({required this.colors});

  @override
  State<_AdditionalSection> createState() => __AdditionalSectionState();
}

class __AdditionalSectionState extends State<_AdditionalSection>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Animation> animations = [];

  @override
  void initState() {
    
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    List<double> beginIntervals = [0.25, 0.3, 0.35, 0.4];
    List<double> endIntervals = [0.7, 0.8, 0.9, 1.0];

    for (int i = 0; i < beginIntervals.length; i++) {
      animations.add(
        Tween(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(beginIntervals[i], endIntervals[i],
                curve: Curves.easeInOut),
          ),
        ),
      );
    }
    // ljkasdfkljalkdjs

    Future.delayed(const Duration(milliseconds: 2800), () {
      animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ProfilePageWidgets._navigationButtons(
            height: c.maxHeight,
            animation: animations[0],
            colors: widget.colors,
            icon: Icon(
              Icons.verified,
              color: Colors.deepPurple,
              size: 25.r,
            ),
            text: 'Become a Pro Member',
          ),
          ProfilePageWidgets._navigationButtons(
            height: c.maxHeight,
            animation: animations[1],
            colors: widget.colors,
            icon: Icon(
              Icons.event_note,
              color: widget.colors.iconColor,
              size: 25.r,
            ),
            text: 'WorkOut Plans',
          ),
          ProfilePageWidgets._navigationButtons(
            height: c.maxHeight,
            animation: animations[2],
            colors: widget.colors,
            icon: Icon(
              Icons.support_agent_rounded,
              color: widget.colors.iconColor,
              size: 25.r,
            ),
            text: 'Support',
          ),
          ProfilePageWidgets._navigationButtons(
            height: c.maxHeight,
            animation: animations[3],
            colors: widget.colors,
            icon: Icon(
              Icons.help,
              color: widget.colors.iconColor,
              size: 25.r,
            ),
            text: 'Help',
          ),
          // Container(),
        ],
      );
    });
  }
}
