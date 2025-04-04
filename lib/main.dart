import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio/just_audio.dart';
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
// ignore: library_prefixes
import 'package:rive_native/rive_native.dart' as riveNative;

// You might want to provide this using dependency injection rather than a
// global variable.
late AudioHandler audioHandler;
Future<void> main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await riveNative.RiveNative.init();

  // Khóa hướng màn hình dọc
  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  HttpOverrides.global = MyHttpOverrides();
  Env.config = getConfig();
  if (!kIsWeb) {
    MobileAds.instance.initialize();
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseFirestore.instance.settings = Settings(
  //     persistenceEnabled: false, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // FirebaseFirestore.instance.enableNetwork();
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  audioHandler = await AudioService.init(
    builder: () => MyAudioHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.mycompany.myapp.channel.audio',
      androidNotificationChannelName: 'Music playback',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );

// theme:
  if (!kIsWeb) {
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
  }

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
      builder: (context, child) {
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            return child ?? SizedBox();
          });
        });
      },
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
        Locale('hi'),
        Locale('th'),
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

class MyAudioHandler extends BaseAudioHandler
    with
        QueueHandler, // mix in default queue callback implementations
        SeekHandler {
  // mix in default seek callback implementations

  AudioPlayer player = AudioPlayer();
  MyAudioHandler() {
    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
    _listenForSequenceStateChanges();
  }

  void _listenForDurationChanges() {
    player.durationStream.listen((duration) {
      var index = player.currentIndex;
      final newQueue = queue.value;
      if (index == null || newQueue.isEmpty) return;
      if (player.shuffleModeEnabled) {
        index = player.shuffleIndices!.indexOf(index);
      }
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    });
  }

  void _listenForCurrentSongIndexChanges() {
    player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (player.shuffleModeEnabled) {
        index = player.shuffleIndices!.indexOf(index);
      }
      mediaItem.add(playlist[index]);
    });
  }

  void _listenForSequenceStateChanges() {
    player.sequenceStateStream.listen((SequenceState? sequenceState) {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem);
      queue.add(items.toList());
    });
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    await player.pause();
    await player.setAsset(
      mediaItem.id,
      tag: mediaItem,
    ); // Schemes: (https: | file: | asset: )
    await player.setLoopMode(LoopMode.all);
    await player.setVolume(0.3);
    await player.play(); // Play while waiting for completion
    // await player.pause(); // Pause but remain ready to play
    // await player.stop();

    playbackState.add(playbackState.value.copyWith(playing: true, controls: [
      MediaControl.pause,
    ]));
  }

  @override
  Future<void> play() {
    playbackState.add(playbackState.value
        .copyWith(playing: true, controls: [MediaControl.pause]));

    return player.play();
  }

  @override
  Future<void> pause() {
    playbackState.add(playbackState.value
        .copyWith(playing: false, controls: [MediaControl.play]));
    return player.pause();
  }

  @override
  Future<void> stop() => player.stop();
  @override
  Future<void> seek(Duration position) => player.seek(position);
  @override
  Future<void> skipToQueueItem(int i) => player.seek(Duration.zero, index: i);

  void _notifyAudioHandlerAboutPlaybackEvents() {
    player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState]!,
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }
}
