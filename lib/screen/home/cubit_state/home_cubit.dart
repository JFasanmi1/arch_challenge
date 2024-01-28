import 'dart:convert';
import 'dart:developer';

import 'package:arch_challenge/core/models/core_model.dart';
import 'package:arch_challenge/core/network/network_service.dart';
import 'package:arch_challenge/screen/home/service/service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/startup/app_startup.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService service;

  HomeCubit(this.service) : super(HomeInitial());

  Future getCoreList() async {
    emit(CoreListLoading());
    try {
      List? body = await service.getCoreList();
      if (body == null) emit(CoreListError("null error"));
      List<CoreModel> coreListModel = (body as List).map((e) => CoreModel.fromJson(e)).toList();
      //registering the model here as cache
      if (serviceLocator.isRegistered<List<CoreModel>>()) {
        serviceLocator.unregister<List<CoreModel>>();
      }
      serviceLocator.registerSingleton<List<CoreModel>>(coreListModel);

      emit(CoreListSuccess());
    } catch (ex) {
      emit(CoreListError(errorHandler(ex)));
    }
  }

}
