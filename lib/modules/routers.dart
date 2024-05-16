import 'package:get/get.dart';
import 'package:terrarium_idle/modules/coop/coop_binding.dart';
import 'package:terrarium_idle/modules/coop/coop_screen.dart';
import 'package:terrarium_idle/modules/event/event_binding.dart';
import 'package:terrarium_idle/modules/event/event_screen.dart';
import 'package:terrarium_idle/modules/garden/garden_binding.dart';
import 'package:terrarium_idle/modules/garden/garden_screen.dart';
import 'package:terrarium_idle/modules/login/login_binding.dart';
import 'package:terrarium_idle/modules/login/login_screen.dart';
import 'package:terrarium_idle/modules/splash/splash_binding.dart';
import 'package:terrarium_idle/modules/splash/splash_screen.dart';
import 'package:terrarium_idle/modules/store/store_binding.dart';
import 'package:terrarium_idle/modules/store/store_screen.dart';
import 'package:terrarium_idle/modules/user/user_binding.dart';
import 'package:terrarium_idle/modules/user/user_screen.dart';

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
  GetPage(
    name: StoreScreen.routeName,
    page: () => const StoreScreen(),
    binding: StoreBinding(),
  ),
  GetPage(
    name: CoopScreen.routeName,
    page: () => const CoopScreen(),
    binding: CoopBinding(),
  ),
  GetPage(
    name: EventScreen.routeName,
    page: () => const EventScreen(),
    binding: EventBinding(),
  ),
  GetPage(
    name: UserScreen.routeName,
    page: () => const UserScreen(),
    binding: UserBinding(),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => const LoginScreen(),
    binding: LoginBinding(),
  ),
];
