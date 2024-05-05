import 'package:get/get.dart';
import 'package:terrarium_idle/modules/garden/garden_binding.dart';
import 'package:terrarium_idle/modules/garden/garden_screen.dart';
import 'package:terrarium_idle/modules/splash/splash_binding.dart';
import 'package:terrarium_idle/modules/splash/splash_screen.dart';

List<GetPage> routes = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: GardenScreen.routeName,
    page: () => const GardenScreen(),
    binding: GardenBinding(),
  ),
];
