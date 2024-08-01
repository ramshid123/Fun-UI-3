import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_project/core/animations/fade_translate_animation.dart';
import 'package:fun_project/core/constants/palette.dart';
import 'package:fun_project/core/constants/shared_pref_strings.dart';
import 'package:fun_project/core/widgets/common.dart';
import 'package:rive/rive.dart' as rive;
import 'package:shared_preferences/shared_preferences.dart';

class HomePageWidgets {
  static Widget kustomFloatingActionButton({
    required Animation animation,
    required ColorConstants colors,
    required SharedPreferences sf,
    required Future<void> Function() changeColorMode,
  }) {
    return _KustomFloatingActionButton(
      parentAnimation: animation,
      colors: colors,
      sf: sf,
      changeColorMode: changeColorMode,
    );
  }

  static Widget progressContainer(
      {required String title,
      required IconData icon,
      required double value,
      required String subtitle,
      required Animation parentAnimation,
      required ColorConstants colors,
      required String content}) {
    return animatedTranslateFade(
      animation: parentAnimation,
      child: _ProgressContainer(
          title: title,
          icon: icon,
          value: value,
          colors: colors,
          subtitle: subtitle,
          content: content),
    );
  }

  static Widget graphContainer({
    required Animation parentAnimation,
    required ColorConstants colors,
  }) {
    return animatedTranslateFade(
      animation: parentAnimation,
      child: _GraphContainer(colors: colors),
    );
  }

  static Widget textContainer({
    required String title,
    required IconData icon,
    required ColorConstants colors,
    required String content,
    required String subtitle,
    required Animation parentAnimation,
  }) {
    return animatedTranslateFade(
      animation: parentAnimation,
      child: _TextContainer(
        title: title,
        icon: icon,
        content: content,
        subtitle: subtitle,
        colors: colors,
      ),
    );
  }

  static Widget waterContainre({
    required Animation parentAnimation,
    required ColorConstants colors,
  }) {
    return animatedTranslateFade(
      animation: parentAnimation,
      child: _WaterContainer(
        colors: colors,
      ),
    );
  }
}

class _WaterContainer extends StatefulWidget {
  final ColorConstants colors;
  const _WaterContainer({required this.colors});

  @override
  State<_WaterContainer> createState() => __WaterContainerState();
}

class __WaterContainerState extends State<_WaterContainer> {
  late rive.StateMachineController _riveController;
  late rive.SMITrigger _trigger;

  @override
  void dispose() {
    _riveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: widget.colors.containreColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(4, 12),
            blurRadius: 14,
            spreadRadius: -8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kText(
                'Water',
                fontSize: 18,
                color: widget.colors.mediumColor,
              ),
              Icon(
                Icons.water_drop_outlined,
                color: widget.colors.iconColor,
                size: 24.r,
              ),
            ],
          ),
          kHeight(20.h),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 100.h,
              child: rive.RiveAnimation.asset(
                'assets/rive/water glass.riv',
                onInit: (artboard) {
                  _riveController = rive.StateMachineController.fromArtboard(
                      artboard, 'State Machine 1')!;
                  artboard.addController(_riveController);

                  _trigger =
                      _riveController.findSMI('raise') as rive.SMITrigger;
                  Future.delayed(
                      const Duration(seconds: 6), () => _trigger.fire());
                },
              ),
              // child: Icon(
              //   Icons.local_drink_rounded,
              //   size: 80.r,
              //   color: Colors.blue,
              // ),
            ),
          ),
          kHeight(20.h),
          kText(
            '2',
            fontSize: 30,
            color: widget.colors.textColor,
          ),
          kText(
            'bottles',
            fontSize: 13,
            color: widget.colors.liteColor,
          ),
        ],
      ),
    );
  }
}

class _ProgressContainer extends StatefulWidget {
  final String title;
  final IconData icon;
  final ColorConstants colors;
  final double value;
  final String subtitle;
  final String content;

  const _ProgressContainer(
      {required this.title,
      required this.icon,
      required this.value,
      required this.subtitle,
      required this.content,
      required this.colors});

  @override
  State<_ProgressContainer> createState() => __ProgressContainerState();
}

class __ProgressContainerState extends State<_ProgressContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Animation> animations = [];

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animations.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
        ),
      ),
    );

    animations.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
        ),
      ),
    );

    animations.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 6), () {
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: widget.colors.containreColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(4, 12),
            blurRadius: 14,
            spreadRadius: -8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kText(
                widget.title,
                fontSize: 18,
                color: widget.colors.mediumColor,
              ),
              kHeight(20.h),
              Icon(
                widget.icon,
                color: widget.colors.iconColor,
                size: 24.r,
              ),
            ],
          ),
          kHeight(30.h),
          AnimatedBuilder(
              animation: animations[1],
              builder: (context, _) {
                return SizedBox(
                  height: 100.r,
                  width: 100.r,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: animations[0].value,
                        child: Transform.rotate(
                          angle: -math.pi / 2 * (1 - animations[1].value),
                          child: SizedBox(
                            height: 100.r,
                            width: 100.r,
                            child: CircularProgressIndicator(
                              strokeWidth: 10.r,
                              value: widget.value * animations[1].value,
                              strokeCap: StrokeCap.round,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.r,
                        width: 100.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 10.r,
                          value: 1,
                          strokeCap: StrokeCap.round,
                          color: Colors.deepPurple.withOpacity(0.3),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          kText(
                            '${(int.parse(widget.content) * animations[2].value).toInt()}',
                            fontSize: 20,
                            color: widget.colors.textColor,
                          ),
                          kText(
                            widget.subtitle,
                            fontSize: 13,
                            color: widget.colors.liteColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          kHeight(20.h),
          Container(),
        ],
      ),
    );
  }
}

class _TextContainer extends StatefulWidget {
  final String title;
  final IconData icon;
  final ColorConstants colors;
  final String content;
  final String subtitle;

  const _TextContainer({
    required this.title,
    required this.icon,
    required this.content,
    required this.subtitle,
    required this.colors,
  });

  @override
  State<_TextContainer> createState() => __TextContainerState();
}

class __TextContainerState extends State<_TextContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    Future.delayed(const Duration(seconds: 6), () {
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: widget.colors.containreColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(4, 12),
            blurRadius: 14,
            spreadRadius: -8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kText(
                widget.title,
                fontSize: 18,
                color: widget.colors.mediumColor,
              ),
              Icon(
                widget.icon,
                color: widget.colors.iconColor,
                size: 24.r,
              ),
            ],
          ),
          kHeight(20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    return kText(
                      (double.parse(widget.content) * animation.value)
                          .toStringAsFixed(2),
                      fontSize: 30,
                      color: widget.colors.textColor,
                    );
                  }),
              kText(
                widget.subtitle,
                fontSize: 13,
                color: widget.colors.liteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _KustomFloatingActionButton extends StatefulWidget {
  final Animation parentAnimation;
  final SharedPreferences sf;
  final ColorConstants colors;
  final Future<void> Function() changeColorMode;
  const _KustomFloatingActionButton({
    required this.parentAnimation,
    required this.colors,
    required this.changeColorMode,
    required this.sf,
  });

  @override
  State<_KustomFloatingActionButton> createState() =>
      __KustomFloatingActionButtonState();
}

class __KustomFloatingActionButtonState
    extends State<_KustomFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<Animation> animations = [];

  Color buttonColor = const Color.fromARGB(255, 35, 35, 35);

  @override
  void initState() {
    buttonColor = widget.sf.getBool(SharedPrefStrings.isLightMode) ?? true
        ? const Color.fromARGB(255, 35, 35, 35)
        : Colors.white;

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animations.add(
      Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
        ),
      ),
    );

    animations.add(
      Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
        ),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.parentAnimation,
        builder: (context, _) {
          return Transform.scale(
            scale: (1 - widget.parentAnimation.value).toDouble(),
            child: SizedBox(
              height: 70.r,
              width: 70.r,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        buttonColor =
                            widget.sf.getBool(SharedPrefStrings.isLightMode) ??
                                    true
                                ? const Color.fromARGB(255, 35, 35, 35)
                                : Colors.white;
                      });
                      widget.changeColorMode();
                      await animationController.forward();
                      animationController.reset();
                    },
                    child: Container(
                      // padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: widget.colors.mediumColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: widget.colors.colorModeIcon,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                      animation: animations[1],
                      builder: (context, _) {
                        return Opacity(
                          opacity: animations[1].value,
                          child: AnimatedBuilder(
                              animation: animations[0],
                              builder: (context, _) {
                                return Transform.scale(
                                  scale: animations[0].value * 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: buttonColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                );
                              }),
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }
}

class _GraphContainer extends StatefulWidget {
  final ColorConstants colors;
  const _GraphContainer({required this.colors});

  @override
  State<_GraphContainer> createState() => __GraphContainerState();
}

class __GraphContainerState extends State<_GraphContainer>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController bmpAnimationController;

  late Animation animation;
  late Animation bmpAnimation;

  ValueNotifier<int> bmp = ValueNotifier(98);

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));

    bmpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    animation = Tween(begin: 1.0, end: 1.1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    bmpAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: bmpAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    initAnimation();

    changeHeartBeat2();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    bmpAnimationController.dispose();
    super.dispose();
  }

  Future initAnimation() async {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 700));
      await animationController.forward();
      await animationController.reverse();
      await animationController.forward();
      await animationController.reverse();
    }
  }

  // Future changeHeartBeat() async {
  //   while (true) {
  //     await Future.delayed(Duration(seconds: math.Random().nextInt(5) + 1));
  //     bmp.value = math.Random().nextInt(40) + 60;
  //   }
  // }

  Future changeHeartBeat2() async {
    while (true) {
      await Future.delayed(Duration(seconds: math.Random().nextInt(5) + 1));
      await bmpAnimationController.forward();
      bmp.value = math.Random().nextInt(40) + 60;
      await bmpAnimationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: widget.colors.containreColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: const Offset(4, 12),
            blurRadius: 14,
            spreadRadius: -8,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          // color: widget.colors.containreColor,
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple.withOpacity(0.5),
              Colors.deepPurple,
              Colors.deepPurple,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                kText(
                  'Heart',
                  color: Colors.white,
                  fontSize: 18,
                ),
                Icon(
                  Icons.heart_broken,
                  color: Colors.white,
                  size: 24.r,
                ),
              ],
            ),
            kHeight(20.h),
            SizedBox(
              height: 100.h,
              child:
                  const rive.RiveAnimation.asset('assets/rive/ecg_pulse.riv'),
            ),
            kHeight(20.h),
            AnimatedBuilder(
                animation: animation,
                builder: (context, _) {
                  return Transform.scale(
                    scale: animation.value,
                    child: AnimatedBuilder(
                        animation: bmpAnimation,
                        builder: (context, _) {
                          return Opacity(
                            opacity: bmpAnimation.value,
                            child: kText(
                              bmp.value.toString(),
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          );
                        }),
                  );
                }),
            kText(
              'bmp',
              color: Colors.white,
              fontSize: 13,
            ),
          ],
        ),
      ),
    );
  }
}
