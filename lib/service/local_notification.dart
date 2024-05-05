import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
// import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

initLocalNotification() async {
  tz.initializeTimeZones();
// / Khởi tạo FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // print('Đang lập lịch thông báo...');
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
    // print('Thông báo được nhận: ${details.payload}');
  });

  // Lập lịch thông báo mỗi ngày lúc 11:30
  _scheduleDailyNotification(flutterLocalNotificationsPlugin);
}

void _scheduleDailyNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'daily_notification',
    'Daily Notification',
    channelDescription: 'Hôm nay bạn đã ghi lại cảm xúc chưa?'.tr,
    importance: Importance.max,
    priority: Priority.max,
  );
  var iosPlatformChannelSpecifics = const DarwinNotificationDetails();
  // ignore: unused_local_variable
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iosPlatformChannelSpecifics,
  );

// Get the local time zone using DateTime class
  // Lấy múi giờ hiện tại của thiết bị
  // Duration deviceTimeZone = DateTime.now().timeZoneOffset;

  var now = tz.TZDateTime.now(tz.local);
  // .add(deviceTimeZone); // Use local time zone
  tz.TZDateTime scheduledTime =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, 15, 00);
  // print('${now} + ${scheduledTime} + ${tz.local}');
  if (scheduledTime.isBefore(now)) {
    // print('Thời gian đã qua, lập lịch cho ngày mai');
    scheduledTime = scheduledTime.add(const Duration(days: 1));
  }
  //  print('Thời gian được lập lịch: $scheduledTime');
  // Lập lịch thông báo
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Daily Notification',
    'Hôm nay bạn đã ghi lại cảm xúc chưa?'.tr,
    // TZDateTime.from(scheduledTime, tz.getLocation(DateTime.now().timeZoneName)),
    scheduledTime,
    // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 30)),
    platformChannelSpecifics,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  final List<PendingNotificationRequest> pendingNotificationRequests =
      await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  if (kDebugMode) {
    print('${pendingNotificationRequests.length} pending notification ');
  }
  // final List<ActiveNotification> activeNotifications =
  //     await flutterLocalNotificationsPlugin.getActiveNotifications();

  //  print('Thông báo đã được lập lịch!');
}
