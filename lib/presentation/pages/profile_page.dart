
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_project/core/animations/fade_translate_animation.dart';
import 'package:fun_project/core/constants/palette.dart';
import 'package:fun_project/core/constants/shared_pref_strings.dart';
import 'package:fun_project/core/widgets/common.dart';
import 'package:fun_project/presentation/widgets/profile_page_widgets.dart';
import 'package:fun_project/init_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  ColorConstants colors = ColorConstantsLight();
  final sf = serviceLocator<SharedPreferences>();

  late AnimationController animationController;
  late AnimationController exitAnimationController;

  List<Animation> animations = [];
  late Animation exitAnimation;

  @override
  void initState() {
    
    final isLightMode = sf.getBool(SharedPrefStrings.isLightMode) ?? true;

    colors = isLightMode ? ColorConstantsLight() : ColorConstantsDark();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    exitAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    exitAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: exitAnimationController, curve: Curves.easeInOut));

    animations.add(
      Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(
            0.0,
            0.5,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    animations.add(
      Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(
            0.5,
            1.0,
            curve: Curves.easeInOut,
          ),
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 2000), () {
      animationController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    
    animationController.dispose();
    exitAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
        exitAnimationController.reset();
        await exitAnimationController.forward().then((c) {
          Navigator.pop(context);
        });
        // if (context.mounted && !didPop) {
        //   Navigator.pop(context);
        // }
        }
      },
      child: Scaffold(
        backgroundColor: colors.backgroundColor,
        body: AnimatedBuilder(
            animation: animations[0],
            builder: (context, _) {
              return Column(
                children: [
                  kHeight(20.h),
                  Opacity(
                    opacity: (1 - animations[0].value).toDouble(),
                    child: AnimatedBuilder(
                        animation: exitAnimation,
                        builder: (context, _) {
                          return Opacity(
                            opacity: exitAnimation.value,
                            child: Row(
                              children: [
                                kWidth(20.w),
                                GestureDetector(
                                  onTap: () async {
                                    await exitAnimationController.forward();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: SizedBox(
                                    child: Icon(
                                      Icons.navigate_before,
                                      color: colors.iconColor,
                                      size: 40.r,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.settings,
                                  color: colors.iconColor,
                                  size: 30.r,
                                ),
                                kWidth(20.w),
                              ],
                            ),
                          );
                        }),
                  ),
                  kHeight(20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: Hero(
                      tag: 'profile_pic',
                      child: Container(
                        // width: size.width,
                        height: 250.r,
                        width: 250.r,
                        decoration: BoxDecoration(
                          // shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(30.r),
                          color: colors.containreColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(4, 12),
                              blurRadius: 14,
                              spreadRadius: -8,
                            ),
                          ],
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Image.asset(
                              'assets/images/me.png',
                              width: size.width,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kHeight(20.h),
                  animatedTranslateFade(
                    animation: animations[0],
                    child: reverseAnimatedTranslateFade(
                      animation: exitAnimation,
                      child: Column(
                        children: [
                          kText(
                            'Ramshid Dilhan',
                            color: colors.textColor,
                            fontSize: 30,
                          ),
                          kHeight(10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: kText(
                              'Developer',
                              color: const Color.fromARGB(255, 142, 130, 163),
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          kHeight(30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  kText(
                                    '234K',
                                    color: colors.textColor,
                                    fontSize: 27,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  kText(
                                    'Followers',
                                    color: colors.mediumColor,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              kWidth(50.w),
                              Column(
                                children: [
                                  kText(
                                    '457',
                                    color: colors.textColor,
                                    fontSize: 27,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  kText(
                                    'Following',
                                    color: colors.mediumColor,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  kHeight(30.h),
                  Expanded(
                    child: AnimatedBuilder(
                        animation: animations[1],
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(
                                0.0, (size.height / 2) * animations[1].value),
                            child: reverseAnimatedTranslateFade(
                              animation: exitAnimation,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                decoration: BoxDecoration(
                                  color: colors.containreColor,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(50.r),
                                  ),
                                ),
                                child: ProfilePageWidgets.additionalSection(
                                  colors: colors,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
