import 'package:fun_project/core/constants/shared_pref_strings.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  final sf = await SharedPreferences.getInstance();
  if (sf.getBool(SharedPrefStrings.isLightMode) == null) {
    await sf.setBool(SharedPrefStrings.isLightMode, true);
  }

  serviceLocator.registerLazySingleton<SharedPreferences>(() => sf);
}
