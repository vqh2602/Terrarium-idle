
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class ThemeService {
//   final _box = GetStorage();
//   final _key = 'isThemeMode';

//   ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

//   // bool loadThemeFromBox() {
//   //   var dataMyTheme = _box.read(Storages.dataTheme);
//   //   if (dataMyTheme != null) {
//   //     myTheme = MyTheme.fromJson(_box.read(Storages.dataTheme));
//   //   }

//   //   return myTheme?.isDarkModel ?? false;
//   // }

//   saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

//   // void switchTheme() {
//   //   Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
//   //   saveThemeToBox(!loadThemeFromBox());
//   // }

//   void setTheme(MyTheme? theme) {
//     // myTheme = listTheme[0];
//     // print(myTheme?.toJson());

//     myTheme = theme;
//     if (theme?.code == 'default') {
//       myTheme = null;
//     }
//     if (myTheme == null) {
//       _box.remove(Storages.dataTheme);
//     } else {
//       // myTheme = null;
//       // print(myTheme?.toJson());
//       _box.write(Storages.dataTheme, myTheme!.toJson());
//       // _box.remove(Storages.dataTheme);}
//     }
//   }
// }

class SThemeTask {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    /// Primary Color
    primaryColor: const Color(0xff70AF68),
    scaffoldBackgroundColor: const Color(0xffffffff),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffffffff),
        iconTheme: IconThemeData(color: Color(0xff495057)),
        actionsIconTheme: IconThemeData(color: Color(0xff495057))),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xfff0f0f0)),
    cardColor: const Color(0xfff0f0f0),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff70AF68),
        splashColor: const Color(0xffeeeeee).withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xff70AF68),
        hoverColor: const Color(0xff70AF68),
        foregroundColor: const Color(0xffeeeeee)),

    /// Divider Theme
    dividerTheme:
        const DividerThemeData(color: Color(0xffe8e8e8), thickness: 1),
    dividerColor: const Color(0xffe8e8e8),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xff70AF68), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff70AF68),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff70AF68), width: 2.0),
      ),
    ),

    /// CheckBox theme
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(const Color(0xffeeeeee)),
      fillColor: MaterialStateProperty.all(const Color(0xff70AF68)),
    ),

    /// Radio theme
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(const Color(0xff70AF68)),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffabb3ea);
        }
        return null;
      }),
      thumbColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xff70AF68);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xff70AF68),
      inactiveTrackColor: const Color(0xff70AF68).withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xff70AF68),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: const Color(0xff70AF68).withOpacity(0.5),
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xffeeeeee),
      ),
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    indicatorColor: const Color(0xff70AF68).withOpacity(0.5),
    highlightColor: const Color(0xff70AF68),
    colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff70AF68),
            primary: const Color(0xff70AF68),
            onBackground: const Color(0xff000000),
            background: const Color(0xffffffff),
            brightness: Brightness.light)
        .copyWith(background: const Color(0xffffffff))
        .copyWith(error: const Color(0xfff0323c)),
  );

  /// -------------------------- Dark Theme  -------------------------------------------- ///
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    /// Primary Color
    primaryColor: const Color(0xff70AF68),

    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xff161616),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xff161616)),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xff222327)),
    cardColor: const Color(0xff222327),

    /// Input (Text-Field) Theme
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Color(0xff70AF68)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(width: 1, color: Colors.white70),
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.white70)),
    ),

    /// Divider Color
    dividerTheme:
        const DividerThemeData(color: Color(0xff363636), thickness: 1),
    dividerColor: const Color(0xff363636),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: const Color(0xff70AF68),
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: const Color(0xff70AF68),
        hoverColor: const Color(0xff70AF68),
        foregroundColor: Colors.white),

    /// Bottom AppBar Theme
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xff70AF68),
      elevation: 2,
    ),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xff495057),
      labelColor: Color(0xff70AF68),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: Color(0xff70AF68), width: 2.0),
      ),
    ),

    ///Switch Theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xffffffff);
        }
        return null;
      }),
      thumbColor: MaterialStateProperty.resolveWith((state) {
        const Set<MaterialState> interactiveStates = <MaterialState>{
          MaterialState.pressed,
          MaterialState.hovered,
          MaterialState.focused,
          MaterialState.selected,
        };
        if (state.any(interactiveStates.contains)) {
          return const Color(0xff70AF68);
        }
        return null;
      }),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: const Color(0xff70AF68),
      inactiveTrackColor: const Color(0xff70AF68).withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: const Color(0xff70AF68),
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.cyan[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),

    ///Other Color
    indicatorColor: Colors.white,
    disabledColor: const Color(0xffa3a3a3),

    highlightColor: Colors.white.withAlpha(28),
    splashColor: Colors.white.withAlpha(56),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xff70AF68),
      brightness: Brightness.dark,
      onBackground: const Color(0xffffffff),
      background: const Color.fromARGB(255, 30, 29, 29),
    )
        .copyWith(
          background: const Color.fromARGB(255, 30, 29, 29),
        )
        .copyWith(error: const Color(0xfff0323c)),
  );
}
