import 'dart:async';

import 'package:arch_challenge/core/config/config.dart';
import 'package:flutter/foundation.dart';

errorLogConfig() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    final exception = details.exception;
    final stackTrace = details.stack;
    if (AppConfig.environment == Environment.dev) {
      FlutterError.dumpErrorToConsole(details);
      // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      if (stackTrace == null) return;
      Zone.current.handleUncaughtError(exception, stackTrace);
      //send to firebase
    }
  };
}
