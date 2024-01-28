import 'package:arch_challenge/core/models/details_models.dart';
import 'package:arch_challenge/core/network/network_service.dart';
import 'package:arch_challenge/screen/details/service/service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/startup/app_startup.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final DetailsService service;

  DetailsCubit(this.service) : super(DetailsInitial());

  Future getSingleCore(String coreSerial) async {
    emit(SingleCoreLoading());
    try {
      Map? body = await service.getSingleCore(coreSerial);
      if (body == null) emit(SingleCoreError("null error"));
      DetailsModel detailsModel = DetailsModel.fromJson(body!);
      //registering the model here as cache
      if (serviceLocator.isRegistered<DetailsModel>()) {
        serviceLocator.unregister<DetailsModel>();
      }
      serviceLocator.registerSingleton<DetailsModel>(detailsModel);

      emit(SingleCoreSuccess());
    } catch (ex) {
      emit(SingleCoreError(errorHandler(ex)));
    }
  }
}
