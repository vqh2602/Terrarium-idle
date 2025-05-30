import 'package:flutter/material.dart';

extension MaterialCode on Color {
  static int floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }

  /// A 32 bit value representing this color.
  ///
  /// The bits are assigned as follows:
  ///
  /// * Bits 24-31 are the alpha value.
  /// * Bits 16-23 are the red value.
  /// * Bits 8-15 are the green value.
  /// * Bits 0-7 are the blue value.
  int get toInt32 {
    return floatToInt8(a) << 24 |
        floatToInt8(r) << 16 |
        floatToInt8(g) << 8 |
        floatToInt8(b) << 0;
  }

  MaterialColor toMaterialColor() {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = {};

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        (r + ((ds < 0 ? r : (255 - r)) * ds).round()).toInt(),
        (g + ((ds < 0 ? g : (255 - g)) * ds).round()).toInt(),
        (b + ((ds < 0 ? b : (255 - b)) * ds).round()).toInt(),
        1,
      );
    }

    return MaterialColor(toInt32, swatch);
  }
}
