import 'dart:async';
import 'dart:io';
import 'package:arch_challenge/core/startup/user_interaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'core/config/config.dart';
import 'core/navigation/generate_route.dart';
import 'core/navigation/keys.dart';
import 'core/navigation/navigation_service.dart';
import 'core/network/http_overrider.dart';
import 'core/startup/app_startup.dart';
import 'core/utils/images.dart';
import 'core/utils/theme.dart';

late Timer rootTimer;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = AppHttpOverrides();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    if (AppConfig.environment == Environment.prod) {
      // do prod stuff
    }
    WidgetsBinding.instance.addObserver(this);
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, _) {
        return Listener(
          onPointerDown: (_) => UserInteraction.it.checkLastInteraction(),
          child: GlobalLoaderOverlay(
            overlayColor: const Color(0xFF354052).withOpacity(.5),
            overlayOpacity: 0.5,
            useDefaultLoading: false,
            disableBackButton: true,
            overlayWidget: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    height: 56.w,
                    width: 56.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    height: 56.w,
                    width: 56.w,
                    padding: EdgeInsets.all(15.w),
                    child: Image.asset(
                      AppAssets.loader,
                      height: 50.w,
                      width: 50.w,
                    ),
                  )
                ],
              ),
            ),
            child: MaterialApp(
              theme: AppTheme.lightThemeData,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              onGenerateRoute: generateRoute,
              initialRoute: RouteKeys.splash,
              navigatorKey: serviceLocator<NavigationService>().navigatorKey,
            ),
          ),
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      UserInteraction.it.checkLastInteraction();
    }
  }
}
