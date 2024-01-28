import 'package:arch_challenge/core/navigation/keys.dart';
import 'package:arch_challenge/core/navigation/navigation_service.dart';
import 'package:arch_challenge/core/startup/app_startup.dart';
import 'package:arch_challenge/core/utils/colors.dart';
import 'package:arch_challenge/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      serviceLocator<NavigationService>().replaceWith(RouteKeys.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.splashBg,
      body: Center(
        child: Image.asset(
          AppAssets.splash,
          width: 200.w,
          height: 200.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
