import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fun_project/presentation/pages/home_page.dart';
import 'package:flutter/services.dart';
import 'package:fun_project/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(392.72727272727275, 803.6363636363636),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fun Project',
        home: HomePage(),
      ),
    );
  }
}
