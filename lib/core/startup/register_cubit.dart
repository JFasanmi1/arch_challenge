
import 'package:arch_challenge/screen/details/cubit_state/details_cubit.dart';
import 'package:arch_challenge/screen/details/service/service.dart';
import 'package:arch_challenge/screen/home/cubit_state/home_cubit.dart';
import 'package:arch_challenge/screen/home/service/service.dart';
import 'package:get_it/get_it.dart';

import '../network/network_service.dart';


void registerCubit(GetIt serviceLocator) {
  serviceLocator.registerSingleton(
    HomeCubit(
      HomeService(
        networkService: NetworkService()
      ),
    ),
  );
  serviceLocator.registerSingleton(
    DetailsCubit(
      DetailsService(
        networkService: NetworkService()
      ),
    ),
  );
}
