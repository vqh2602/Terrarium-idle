import 'package:flutter/material.dart';

enum STextTheme {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

extension STextThemeExtension on STextTheme {
  TextStyle? value(BuildContext context,) {
    switch (this) {
      case STextTheme.displayLarge:
        return Theme.of(context).textTheme.displayLarge;
      case STextTheme.displayMedium:
        return Theme.of(context).textTheme.displayMedium;
      case STextTheme.displaySmall:
        return Theme.of(context).textTheme.displaySmall;
      case STextTheme.headlineLarge:
        return Theme.of(context).textTheme.headlineLarge;
      case STextTheme.headlineMedium:
        return Theme.of(context).textTheme.headlineMedium;
      case STextTheme.headlineSmall:
        return Theme.of(context).textTheme.headlineSmall;
      case STextTheme.titleLarge:
        return Theme.of(context).textTheme.titleLarge;
      case STextTheme.titleMedium:
        return Theme.of(context).textTheme.titleMedium;
      case STextTheme.titleSmall:
        return Theme.of(context).textTheme.titleSmall;
      case STextTheme.bodyLarge:
        return Theme.of(context).textTheme.bodyLarge;
      case STextTheme.bodyMedium:
        return Theme.of(context).textTheme.bodyMedium;
      case STextTheme.bodySmall:
        return Theme.of(context).textTheme.bodySmall;
      case STextTheme.labelLarge:
        return Theme.of(context).textTheme.labelLarge;
      case STextTheme.labelMedium:
        return Theme.of(context).textTheme.labelMedium;
      case STextTheme.labelSmall:
        return Theme.of(context).textTheme.labelSmall;
      }
  }
}
