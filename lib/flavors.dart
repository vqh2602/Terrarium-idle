enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Terrarium idle (dev)';
      case Flavor.prod:
        return 'Terrarium idle';
      default:
        return 'title';
    }
  }

}
