import 'dart:io';
import 'dart:math';

// import 'package:appwrite/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:terrarium_idle/data/models/user.dart';

import 'package:terrarium_idle/widgets/text_custom.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: constant_identifier_names
enum TypeDate { ddMMyyyy, yyyyMMdd, ddMMyyyyhhmm, hhmm, dd, yyyy, mM, mMyyyy }

// ignore: constant_identifier_names
enum TypeSound { rain, tap }

class ShareFuntion {
  static final player = AudioPlayer();
  static Future<void> dateTimePickerCupertino(
      {required Function(DateTime) onchange,
      DatePickerDateOrder? dateOrder,
      DateTime? initialDateTime,
      CupertinoDatePickerMode mode =
          CupertinoDatePickerMode.dateAndTime}) async {
    await Get.bottomSheet(
        backgroundColor: Get.theme.colorScheme.background,
        Container(
          height: 250,
          padding: EdgeInsets.zero,
          child: CupertinoDatePicker(
              onDateTimeChanged: onchange,
              initialDateTime: initialDateTime ?? DateTime.now(),
              //backgroundColor: Colors.white,
              dateOrder: dateOrder ?? DatePickerDateOrder.dmy,
              mode: mode),
        ));
  }

  static Future<DateTime?> dateTimePickerMaterial({
    BuildContext? context,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
  }) async {
    return await showDatePicker(
        context: context ?? Get.context!,
        initialEntryMode: initialEntryMode,
        initialDatePickerMode: initialDatePickerMode,
        locale: const Locale('vi'),
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
  }

  static Future<TimeOfDay?> timePickerMaterial({
    BuildContext? context,
  }) async {
    return await showTimePicker(
      // initialEntryMode: TimePickerEntryMode.dialOnly,

      context: context ?? Get.context!, initialTime: TimeOfDay.now(),
    );
  }

  static String formatDate({required TypeDate type, dynamic dateTime}) {
    if (dateTime == null) return ''.tr;
    if (dateTime is String) dateTime = DateTime.parse(dateTime);
    if (dateTime is DateTime) dateTime = dateTime;
    switch (type) {
      case TypeDate.ddMMyyyy:
        return DateFormat('dd-MM-yyyy').format(dateTime);
      case TypeDate.yyyyMMdd:
        return DateFormat('yyyy-MM-dd').format(dateTime);
      case TypeDate.ddMMyyyyhhmm:
        return DateFormat('dd-MM-yyyy hh:mm').format(dateTime);
      case TypeDate.hhmm:
        return DateFormat('HH:mm').format(dateTime);
      case TypeDate.dd:
        return dateTime.day.toString();
      case TypeDate.yyyy:
        return dateTime.year.toString();
      case TypeDate.mM:
        return dateTime.month.toString();
      case TypeDate.mMyyyy:
        return DateFormat('MM-yyyy').format(dateTime);
    }
  }

// khoảng cách ngày
  static int daysBetween({required DateTime from, required DateTime to}) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    int days = (to.difference(from).inHours / 24).round();
    return days <= 0 ? 0 : days;
  }

//tính buổi
  static String getSesisonDay() {
    DateTime dt = DateTime.now();
    if (dt.hour >= 18 || (dt.hour >= 0 && dt.hour < 4)) return 'tối'.tr;
    if (dt.hour >= 4 && dt.hour < 11) return 'sáng'.tr;
    if (dt.hour >= 11 && dt.hour < 13) return 'trưa'.tr;
    return 'chiều'.tr;
  }

  static Future<String> getCurrentUrl(String url) async {
    if (Platform.isIOS) {
      String a = url.substring(url.indexOf("Documents/") + 10, url.length);
      Directory dir = await getApplicationDocumentsDirectory();
      a = "${dir.path}/$a";
      //print('aaa $a');
      return a;
    } else {
      return url;
    }
  }

  static Future<void> onPopDialog(
      {required BuildContext context,
      required String title,
      String? titleCancel,
      String? titleSubmit,
      required Function onCancel,
      required Function onSubmit}) async {
    await showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: textBodyMedium('Thông báo'.tr, fontWeight: FontWeight.bold),
        content: Container(
          margin: const EdgeInsets.only(top: 12),
          child: textBodySmall(
            title,
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: textBodySmall(titleCancel ?? "Hủy".tr,
                color: Get.theme.colorScheme.error,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
            onPressed: () {
              // Navigator.of(context).pop(false);
              onCancel();
            },
          ),
          CupertinoDialogAction(
            child: textBodySmall(titleSubmit ?? 'Xác nhận'.tr,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3),
            onPressed: () {
              // Navigator.of(context).pop(true);
              onSubmit();
            },
          ),
        ],
      ),
    );
  }

  static String getLocalConvertString() {
    Locale? locale = Get.deviceLocale;
    //print('vitri : ${locale?.languageCode}');
    switch (locale?.languageCode.toString()) {
      case 'en':
        return 'en';
      case 'vi':
        return 'vi';
      default:
        return 'en';
    }
  }

  static showWebInApp(String url,
      {LaunchMode mode = LaunchMode.inAppWebView}) async {
    if (!await launchUrl(Uri.parse(url), mode: mode)) {
      throw Exception('Could not launch $url');
    }
  }

  static String formatCurrency(num number, {String? symbol}) {
    return NumberFormat.currency(locale: 'vi_VN', symbol: symbol ?? 'đ')
        .format(number);
  }

  static String formatNumber({required String number}) {
    try {
      num n = num.parse(number);
      if (n >= 1000 && n < 1000000) {
        double numberInN = n / 1000.0;
        return '${NumberFormat("#.#").format(numberInN)}N';
      } else if (n >= 1000000) {
        double numberInTR = n / 1000000.0;
        return '${NumberFormat("#.#").format(numberInTR)}TR';
      } else {
        return number.toString();
      }
    } on Exception catch (_) {}
    return 'Trống';
  }

  // tìm và sắp sếp phân ftuwr đuọc tìm kiếm lên đầu list
  static searchList(
      {required List? list, required String value, required Function update}) {
    for (var role in list ?? []) {
      if (role?.key?.toLowerCase().contains(value.toLowerCase()) ??
          false || role?.value?.toLowerCase().contains(value.toLowerCase()) ??
          false) {
        list?.remove(role);
        list?.insert(0, role);
      }
    }
    update();
  }

  // check dữ liệu nhập
  static String? validateString(String? text) {
    if (text == null || text.isEmpty) {
      return "Trường bắt buộc";
    }
    return null;
  }

// kiểm tra dịch vụ app còn khả dụng?
  static bool checkExpiry({required UserData? user}) {
    if (user == null) {
      return false;
    }
    switch (user.user?.identifier) {
      case 'month':
        if (user.user?.latestPurchaseDate != null &&
            DateTime.now().isBefore(
                user.user!.latestPurchaseDate!.add(const Duration(days: 30)))) {
          return true;
        }
        return false;
      case 'year':
        if (user.user?.latestPurchaseDate != null &&
            DateTime.now().isBefore(user.user!.latestPurchaseDate!
                .add(const Duration(days: 365)))) {
          return true;
        }
        return false;
      default:
        return false;
    }
  }

  static tapPlayAudio(
      {TypeSound type = TypeSound.tap, bool isNewAudioPlay = false}) async {
    var playerAudio = player;
    if (isNewAudioPlay) {
      playerAudio = AudioPlayer();
    }

    if (playerAudio.playing) {
      playerAudio.pause();
    } else {
      // Create a player
      switch (type) {
        case TypeSound.rain:
          await playerAudio.setAsset('assets/audios/rain.mp3');
        case TypeSound.tap:
          await playerAudio.setAsset('assets/audios/tap.mp3');
      }
      await playerAudio.play(); // Play while waiting for completion
      // await player.pause(); // Pause but remain ready to play
      await playerAudio.stop();
    }
  }

// Hàm gacha
  static bool gacha({int winRate = 30}) {
    // Sinh số ngẫu nhiên từ 0 đến 99
    int randomNumber = Random().nextInt(100);

    // Nếu số ngẫu nhiên <= winRate, trúng giải
    if (randomNumber <= winRate) {
      return true;
    } else {
      return false;
    }
  }

  static UserData updateLevel(UserData userData) {
    //LEVEL USER
    int expUser = userData.user?.userLevelEXP ?? 0;
    int level = userData.user?.userLevel ?? 1;

    if (expUser >= (1000 * level) * 0.75) {
      userData = userData.copyWith(
          user: userData.user?.copyWith(userLevel: level + 1, userLevelEXP: 0));
    }
    //LEVEL PLANT
    List<Plants> plants = userData.plants!;
    for (int i = 0; i < plants.length; i++) {
      if (plants[i].platLevelExp != null && plants[i].plantLevel != null) {
        if (plants[i].platLevelExp! >= (3000 * plants[i].plantLevel!) * 0.95) {
          plants[i] = plants[i]
              .copyWith(plantLevel: plants[i].plantLevel! + 1, platLevelExp: 0);
        }
      }
    }
    userData = userData.copyWith(plants: plants);
    return userData;
  }

  static bool isIpad() {
    return Get.width >= 600;
  }
}

/// xoá phần tử giống nhau
Iterable<T> distinct<T>(Iterable<T> elements) sync* {
  final visited = <T>{};
  for (final el in elements) {
    if (visited.contains(el)) continue;
    yield el;
    visited.add(el);
  }
}
