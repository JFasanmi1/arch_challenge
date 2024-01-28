

enum Environment { dev, uat, prod }

extension EnvironmentExt on Environment {
  int get rank {
    switch (this) {
      case Environment.dev:
        return 0;
      case Environment.uat:
        return 1;
      case Environment.prod:
        return 2;
    }
  }
}

class AppConfig {
  AppConfig._();
  static const String appPackageAndroid = "com.arch.challenge.arch_challenge";

  // WARNING: Do not modify this set values inside this file
  static late Environment environment;
  static String? version;
  static String? state;
  static String? country;
  static String? deviceName;
  static String? sessionTime;
}
