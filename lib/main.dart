import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terrarium_idle/c_lang/c_translations.dart';
import 'package:terrarium_idle/c_theme/c_theme.dart';
import 'package:terrarium_idle/config/config.dart';
import 'package:terrarium_idle/config/get_config.dart';
import 'package:terrarium_idle/firebase_options.dart';
import 'package:terrarium_idle/service/app_links_service.dart';
import 'package:terrarium_idle/modules/init.dart';
import 'package:terrarium_idle/modules/routers.dart';
import 'package:terrarium_idle/modules/splash/splash_screen.dart';
import 'package:terrarium_idle/service/firebase_config.dart';
import 'package:terrarium_idle/service/firebase_push.dart';
import 'package:terrarium_idle/service/local_notification.dart';

Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Env.config = getConfig();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );

// theme:
  Env.config.lightTheme = SThemeTask.lightTheme.copyWith(
    textTheme: Platform.isMacOS || Platform.isWindows
        ? SThemeTask.lightTheme.textTheme
        : GoogleFonts.maliTextTheme(Env.config.lightTheme.textTheme),
  );

  Env.config.darkTheme = SThemeTask.darkTheme.copyWith(
    textTheme: Platform.isMacOS || Platform.isWindows
        ? SThemeTask.darkTheme.textTheme
        : GoogleFonts.maliTextTheme(Env.config.darkTheme.textTheme),
  );

  await initialize();
  LocalNotification().initLocalNotification();
  AppLinksService().initDeepLinks();
  FirebaseCouldMessage.init();
  RemoteConfig.initRemoteConfig();
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: routes,
      locale: Get.deviceLocale,
      translations: Messages(),
      navigatorObservers: const [
        // firebaseAnalyticsService.appAnalyticsObserver(),
      ],
      fallbackLocale: const Locale('vi', 'VN'),
      theme: Env.config.lightTheme,
      // darkTheme: SThemeTask.darkTheme,
      // themeMode: ThemeService().theme,
      // themeMode:  ThemeMode.dark ,
      // builder: (context, child) {
      //   ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      //     return CustomError(errorDetails: errorDetails);
      //   };
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      //     // textDirection: AppTheme.textDirection,
      //     child: child!,
      //   );
      // },
      localizationsDelegates: const [
        // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi'),
        Locale('en'),
        Locale('zh'),
        Locale('ko'),
        Locale('ja'),
        Locale('ru'),
      ],
      transitionDuration: const Duration(milliseconds: 300),
      defaultTransition: Transition.fadeIn,
      initialRoute: SplashScreen.routeName,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
