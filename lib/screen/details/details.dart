import 'dart:io';

import 'package:arch_challenge/core/models/details_models.dart';
import 'package:arch_challenge/core/navigation/navigation_service.dart';
import 'package:arch_challenge/core/startup/app_startup.dart';
import 'package:arch_challenge/core/utils/colors.dart';
import 'package:arch_challenge/core/utils/styles.dart';
import 'package:arch_challenge/core/utils/utils.dart';
import 'package:arch_challenge/screen/details/cubit_state/details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';


class DetailsScreen extends StatefulWidget {

  String routeVariable;
  DetailsScreen({super.key, required this.routeVariable});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  DetailsModel? detailsModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    //mostly no need to register this response because we want updated value each time we click details
    context.loaderOverlay.show();
    await serviceLocator<DetailsCubit>().getSingleCore(widget.routeVariable);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.routeVariable} Details",
          style: AppStyle.textXSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
        elevation: 5,
        actions: const [

        ],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 50.w,
            height: 50.h,
            decoration: const BoxDecoration(
              color: AppColors.primaryActive,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {
                serviceLocator<NavigationService>().pop();
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                size: 40.sp,
              ),
            ),
          ),
        ),
      ),
      body: BlocListener(
        bloc: serviceLocator<DetailsCubit>(),
        listener: (context, DetailsState state) {
          if (state is SingleCoreLoading) {
            context.loaderOverlay.show();
          }
          if (state is SingleCoreSuccess) {
            detailsModel = serviceLocator<DetailsModel>();
            context.loaderOverlay.hide();
            setState(() {});
          }
          if (state is SingleCoreError) {
            context.loaderOverlay.hide();
          }
        },
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _coreDefinitionHeader(),
            const SizedBox(
              height: 10,
            ),
            detailsModel == null
                ? Container()
                : definitionWidget(),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Row _coreDefinitionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is a Core",
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  Widget definitionWidget() {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      //width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailsModel!.details!,
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                 ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.purple[300],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatDatefromTimeStamp(detailsModel!.originalLaunchUnix!).toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Water landing - ${detailsModel!.waterLanding}",
                    style: const TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Icon(
            Icons.rocket_rounded,
            size: 60,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}
