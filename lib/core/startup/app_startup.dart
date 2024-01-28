import 'package:arch_challenge/core/models/core_model.dart';
import 'package:arch_challenge/core/navigation/navigation_service.dart';
import 'package:arch_challenge/core/network/network_info.dart';
import 'package:arch_challenge/core/startup/error_config.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'environment.dart';
import 'register_cubit.dart';

final GetIt serviceLocator = GetIt.I;

Future initLocator() async {
  serviceLocator.allowReassignment = true;
  setupConfig();

  errorLogConfig();
  serviceLocator.registerSingleton<NavigationService>(NavigationService());

  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );


  registerCubit(serviceLocator);

  // This should be called last
  serviceLocator.pushNewScope(scopeName: 'app_start');
}

clearUserData() async {
  if (serviceLocator.isRegistered<CoreModel>()) {
    serviceLocator.unregister<CoreModel>();
  }

  await serviceLocator.resetScope();
}