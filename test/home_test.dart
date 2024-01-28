

import 'package:arch_challenge/core/startup/app_startup.dart';
import 'package:arch_challenge/core/startup/register_cubit.dart';
import 'package:arch_challenge/core/utils/widgetKeys.dart';
import 'package:arch_challenge/screen/home/cubit_state/home_cubit.dart';
import 'package:arch_challenge/screen/home/home.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'bloc/mocks.dart';

void main() {

  setUp(() {
    serviceLocator.reset();
    registerCubit(serviceLocator);
  });

  testWidgets('Check for Appbar on HomeScreen', (WidgetTester tester) async {
    await renderSubject(tester, HomeInitial());
    expect(find.byKey(WidgetKeys.HOME_APPBAR_KEY), findsOneWidget);
  });
  testWidgets('Check for HomScreen Heading', (WidgetTester tester) async {
    await renderSubject(tester, HomeInitial());
    expect(find.byKey(WidgetKeys.HOME_TITLE_KEY), findsOneWidget);
  });
  }

  renderSubject(WidgetTester tester, HomeState homeState) async {
  final subject = MaterialApp(
      home: ScreenUtilInit(
        designSize: const Size(800, 600),
        builder: (_, widget) {
          final mockHomeCubit = MockHomeCubit();
          whenListen(mockHomeCubit, Stream.fromIterable([homeState]), initialState: homeState);
          return GlobalLoaderOverlay(
            overlayColor: const Color(0xFF354052).withOpacity(.5),
            overlayOpacity: 0.5,
            useDefaultLoading: false,
            disableBackButton: true,
            overlayWidget: SizedBox(
              width: double.maxFinite,
              height: double.maxFinite,
              child: Container(),
            ),
            child: BlocProvider<HomeCubit>(
              create: (context) => mockHomeCubit,
              child: const HomeScreen(),
            ),
          );
        },
      )
  );

  await tester.pumpWidget(subject);
  await tester.pumpAndSettle();
}