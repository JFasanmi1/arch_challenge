import 'package:arch_challenge/core/navigation/keys.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  pop() async {
    return navigatorKey.currentState!.pop();
  }

  bool get canPop => navigatorKey.currentState?.canPop() ?? false;

  popWithData(Map data) async {
    navigatorKey.currentState!.pop(data);
  }

  Future clearAllTo(String routeName, {Map? data}) async {
    navigatorKey.currentContext?.loaderOverlay.hide();
    return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName,
        (route) => route.settings.name == RouteKeys.home,
        arguments: data);
  }

  popUntil(String route) =>
      navigatorKey.currentState!.popUntil(ModalRoute.withName(route));

  Future clearAllWithParameter(
      {required String routeName, required Map data}) async {
    navigatorKey.currentContext?.loaderOverlay.hide();
    return await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => route.isFirst,
            arguments: data);
  }

  Future to(String routeName) async {
    navigatorKey.currentContext?.loaderOverlay.hide();
    return await navigatorKey.currentState!.pushNamed(routeName);
  }

  Future toWithPameter({required String routeName, required Map data}) async {
    navigatorKey.currentContext?.loaderOverlay.hide();
    return await navigatorKey.currentState!
        .pushNamed(routeName, arguments: data);
  }

  Future replaceWith(String routeName) async {
    navigatorKey.currentContext?.loaderOverlay.hide();
    return await navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future replaceWithPameter(
      {required String routeName, required Map data}) async {
    navigatorKey.currentContext?.loaderOverlay.hide();
    return await navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: data);
  }
}

class CustomRoutes {
  static Route fadeIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeInExpo;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static Route slideIn({required Widget page, RouteSettings? settings}) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = const Offset(10, 0);
        var end = Offset.zero;
        var curve = Curves.easeInExpo;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  static Route slideUp(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = const Offset(0, 1);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: page,
        );
      },
    );
  }
}
