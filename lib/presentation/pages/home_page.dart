import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_project/core/constants/palette.dart';
import 'package:fun_project/core/constants/shared_pref_strings.dart';
import 'package:fun_project/core/widgets/common.dart';
import 'package:fun_project/presentation/pages/profile_page.dart';
import 'package:fun_project/presentation/widgets/home_page_widgets.dart';
import 'package:fun_project/init_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final sf = serviceLocator<SharedPreferences>();

  late AnimationController animationController;
  List<Animation> animations = [];
  ColorConstants colors = ColorConstantsLight();

  Future changeColorMode() async {
    final isLightMode = sf.getBool(SharedPrefStrings.isLightMode) ?? true;
    await sf.setBool(SharedPrefStrings.isLightMode, !isLightMode);
    await Future.delayed(const Duration(seconds: 1));
    colors = !isLightMode ? ColorConstantsLight() : ColorConstantsDark();
    setState(() {});
  }

  @override
  void initState() {
    final isLightMode = sf.getBool(SharedPrefStrings.isLightMode) ?? true;

    colors = isLightMode ? ColorConstantsLight() : ColorConstantsDark();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    animations.add(
      Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.0, 0.2, curve: Curves.easeInOut),
        ),
      ),
    );

    // lakjsdflkjsadflkj

    for (int i = 2; i <= 7; i++) {
      animations.add(
        Tween(begin: 1.0, end: 0.0).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Interval(i * 0.1, i * 0.1 + 0.2, curve: Curves.easeInOut),
          ),
        ),
      );
    }

    animations.add(
      Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.9, 1.0, curve: Curves.decelerate),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      floatingActionButton: HomePageWidgets.kustomFloatingActionButton(
          changeColorMode: changeColorMode,
          sf: sf,
          animation: animations[7],
          colors: colors),
      body: SafeArea(
        child: Container(
          clipBehavior: Clip.none,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight(20.h),
                // APP BAR
                AnimatedBuilder(
                    animation: animations[0],
                    builder: (context, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: (1 - animations[0].value).toDouble(),
                                child: Transform.translate(
                                  offset:
                                      Offset(0.0, -20.h * animations[0].value),
                                  child: kText(
                                    'Tue, 2 Jan',
                                    fontSize: 20,
                                    color: colors.textColor,
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: (1 - animations[0].value).toDouble(),
                                child: Transform.translate(
                                  offset:
                                      Offset(30.w * animations[0].value, 0.0),
                                  child: GestureDetector(
                                    onTap: () async =>
                                        await Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) =>
                                                    const HomePage()),
                                            (c) => false),
                                    child: kText(
                                      'My Day',
                                      fontSize: 35,
                                      color: colors.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.blue,
                          // ),
                          Opacity(
                            opacity: (1 - animations[0].value).toDouble(),
                            child: Transform.translate(
                              offset: Offset(0.0, 30.h * animations[0].value),
                              child: GestureDetector(
                                onTap: () async => await Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 2500),
                                    reverseTransitionDuration:
                                        const Duration(seconds: 1),
                                    pageBuilder: (context, anim1, anim2) =>
                                        const ProfilePage(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var curve = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeInOutQuart,
                                      );

                                      return Opacity(
                                        opacity: curve.value,
                                        child: Transform.translate(
                                          offset: Offset(
                                              0.0,
                                              (size.height * (1 - curve.value)) +
                                                  (200.r * (1 - curve.value))),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: colors.backgroundColor,
                                                  offset: Offset(0, -50.r),
                                                  blurRadius: 50.r,
                                                  spreadRadius: 50.r,
                                                ),
                                              ],
                                            ),
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                child: Hero(
                                  tag: 'profile_pic',
                                  child: Container(
                                    height: 50.r,
                                    width: 50.r,
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
                                    child: Center(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        child: Image.asset(
                                          'assets/images/me.png',
                                          width: size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                // Body
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HomePageWidgets.progressContainer(
                            colors: colors,
                            parentAnimation: animations[1],
                            title: 'Walk',
                            icon: Icons.directions_walk_outlined,
                            value: 0.75,
                            subtitle: 'Steps',
                            content: '2232',
                          ),
                          HomePageWidgets.textContainer(
                            parentAnimation: animations[3],
                            colors: colors,
                            title: 'Sleep',
                            icon: Icons.nightlight_outlined,
                            content: '7.21',
                            subtitle: 'hours',
                          ),
                          HomePageWidgets.waterContainre(
                            parentAnimation: animations[5],
                            colors: colors,
                          ),
                        ],
                      ),
                    ),
                    kWidth(20.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HomePageWidgets.graphContainer(
                              parentAnimation: animations[2], colors: colors),
                          HomePageWidgets.progressContainer(
                            parentAnimation: animations[4],
                            colors: colors,
                            title: 'Calories',
                            icon: Icons.electric_bolt_sharp,
                            value: .75,
                            subtitle: 'kcal',
                            content: '553',
                          ),
                          HomePageWidgets.textContainer(
                            parentAnimation: animations[6],
                            title: 'Gym',
                            icon: Icons.sports_gymnastics,
                            colors: colors,
                            content: '45',
                            subtitle: 'min',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
