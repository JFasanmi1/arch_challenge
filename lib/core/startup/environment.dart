import 'dart:io';

import 'package:arch_challenge/core/config/config.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

setupConfig() {
  // AppConfig.environment should always be the first line in this file
  AppConfig.environment = Environment.values.firstWhere(
    (element) => element.name == const String.fromEnvironment("env"),
    orElse: () => Environment.dev,
  );
  _getUserLocation();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    deviceInfo.androidInfo.then((info) {
      AppConfig.deviceName = info.model;
    });
  } else if (Platform.isIOS) {
    deviceInfo.iosInfo.then((info) {
      AppConfig.deviceName = info.utsname.machine;
    });
  }

  // PackageInfo.fromPlatform().then((packageInfo) {
  //   AppConfig.version = packageInfo.version;
  // });
  AppConfig.version = "1.0.0";
}

_getUserLocation() async {
  try {
    Response response = await Dio().get('http://ip-api.com/json');
    if (response.statusCode == 200) {
      Map data = response.data as Map;
      AppConfig.state = data['regionName'] ?? '';
      AppConfig.country = data['country'] ?? '';
    }
  } catch (_) {}
}

