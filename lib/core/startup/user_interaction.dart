import 'package:arch_challenge/core/config/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserInteraction {
  UserInteraction._();
  static DateTime? _lastinteractionTime;

  static UserInteraction get it => UserInteraction._();

  void checkLastInteraction() {
    if (kDebugMode) return;
    FocusManager.instance.primaryFocus?.unfocus();
    checkUserActivity();
  }

  void checkUserActivity() {
    //the below means no user logged in hence interaction should be canceled
    // if (userNotifier.value == null) {
    //   _lastinteractionTime = null;
    //   return;
    // }
    _lastinteractionTime ??= DateTime.now();
    int differenceInMinutes =
        DateTime.now().difference(_lastinteractionTime!).inMinutes;
    int timeOutTime = AppConfig.environment == Environment.dev ? 360 : 5;
    if (differenceInMinutes >= timeOutTime) {
      //logoutUser(LoginSource.timeout);
    } else {
      _lastinteractionTime = DateTime.now();
    }
  }
}
