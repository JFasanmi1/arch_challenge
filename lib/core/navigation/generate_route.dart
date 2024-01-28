import 'package:arch_challenge/core/navigation/keys.dart';
import 'package:arch_challenge/screen/details/details.dart';
import 'package:arch_challenge/screen/home/home.dart';
import 'package:arch_challenge/screen/splash/root.dart';
import 'package:flutter/material.dart';

Route generateRoute(RouteSettings settings) {
  String routeName = settings.name ?? '';

  switch (routeName) {
    case RouteKeys.splash:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const SplashScreen());
    case RouteKeys.home:
          return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
    case RouteKeys.details:
      Map? args = settings.arguments as Map?;
        return MaterialPageRoute(
            settings: settings, builder: (_) => DetailsScreen(routeVariable: args?['routeVariable']));

    default:
      return MaterialPageRoute(
          settings: settings,
          builder: (_) => _ErrorScreen(routeName: routeName));
  }
}

class _ErrorScreen extends StatelessWidget {
  final String routeName;
  const _ErrorScreen({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Route '$routeName' does not exist"),
      ),
    );
  }
}
