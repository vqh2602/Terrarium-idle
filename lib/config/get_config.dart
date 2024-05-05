// ignore_for_file: file_names
import 'package:terrarium_idle/config/config.dart';
import 'package:terrarium_idle/config/config_dev.dart' as dev;
import 'package:terrarium_idle/config/config_prod.dart' as prod;
import 'package:terrarium_idle/flavors.dart';
import 'package:flutter/foundation.dart';

ModuleConfig getConfig() {
  switch (F.name.toLowerCase()) {
    case "dev":
      if (kDebugMode) {
        print(F.name);
      }
      return dev.Environment();
    case "prod":
      if (kDebugMode) {
        print(F.name);
      }
      return prod.Environment();
    default:
      return dev.Environment();
  }
}
