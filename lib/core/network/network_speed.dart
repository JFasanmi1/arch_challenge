import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../navigation/navigation_service.dart';
import '../startup/app_startup.dart';
import '../utils/colors.dart';

Future<void> estimateNetworkSpeed() async {
  late String speed;
  const fileUrl =
      'https://firebasestorage.googleapis.com/v0/b/armone-c6065.appspot.com/o/do_not_delete.png?alt=media'; // Replace with a large file URL
  final stopwatch = Stopwatch()..start();
  Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    if (stopwatch.elapsed.inSeconds > 2) {
      showDialog(
          context:
              serviceLocator<NavigationService>().navigatorKey.currentContext!,
          barrierDismissible: true,
          useRootNavigator: false,
          builder: (context) {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(
                  bottom: 0, left: 25, right: 10, top: 10),
              title: Text(
                "Network Issues",
                style: TextStyle(
                  fontSize: 20.sp,
                  height: 1.26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.body,
                ),
              ),
              content: Text(
                'Your internet connection is unstable. This might cause delayed loading time.',
                style: TextStyle(
                  fontSize: 16.sp,
                  height: 1.26,
                  fontWeight: FontWeight.w500,
                  color: AppColors.body,
                ),
              ),
              actions: [
                SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () {
                        serviceLocator<NavigationService>().pop();
                      },
                      child: const Text('OK')),
                ),
              ],
            );
          });

      timer.cancel();
    }
  });

  final HttpClient httpClient = HttpClient();

  try {
    final HttpClientRequest request =
        await httpClient.getUrl(Uri.parse(fileUrl));
    final HttpClientResponse response = await request.close();

    final int bytesRead = await response.fold<int>(
        0, (previous, element) => previous + element.length);

    final elapsed = stopwatch.elapsedMilliseconds / 1000; // Convert to seconds
    final speedInBytesPerSecond = (bytesRead) / elapsed;

    speed =
        '${(speedInBytesPerSecond / 1024 / 1024).toStringAsFixed(2)} Mbps $elapsed';
    debugPrint("Network Speed: $speed");
    timer.cancel();
  } catch (error) {
    speed = 'Error';
  } finally {
    httpClient.close();
  }
}
