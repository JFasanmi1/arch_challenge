import 'package:arch_challenge/core/startup/app_startup.dart';
import 'package:arch_challenge/core/utils/colors.dart';
import 'package:arch_challenge/core/utils/styles.dart';
import 'package:arch_challenge/core/utils/utils.dart';
import 'package:arch_challenge/core/utils/widgetKeys.dart';
import 'package:arch_challenge/screen/home/cubit_state/home_cubit.dart';
import 'package:arch_challenge/widgets/task_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../core/models/core_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<CoreModel>? coreListModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    context.loaderOverlay.show();
    //Am using this to cache the response from the call such that
    //the api call is made just once (so long as the model response is registered/saved)
    //this cache can be cleared using clearUserData() in lib/core/startup/app_startup.dart:32
    await serviceLocator<HomeCubit>().getCoreList();
    if (serviceLocator.isRegistered<List<CoreModel>>()) {
      coreListModel = serviceLocator<List<CoreModel>>();
    } else {
      coreListModel = serviceLocator<List<CoreModel>>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: WidgetKeys.HOME_APPBAR_KEY,
        title: Text(
          fetchCurrentDate(","),
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
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                Icons.menu_rounded,
                size: 40.sp,
              ),
            ),
          ),
        ),
      ),
      body: BlocListener(
        bloc: serviceLocator<HomeCubit>(),
        listener: (context, HomeState state) {
          if (state is CoreListLoading) {
            context.loaderOverlay.show();
          }
          if (state is CoreListSuccess) {
            coreListModel = serviceLocator<List<CoreModel>>();
            context.loaderOverlay.hide();
            setState(() {});
          }
          if (state is CoreListError) {
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
            const SizedBox(
              height: 10,
            ),
            _coreHeader(),
            const SizedBox(
              height: 15,
            ),
            buildGrid(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Row _coreHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SelectableText(
          "SpaceX Core",
          key: WidgetKeys.HOME_TITLE_KEY,
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        ),
      ],
    );
  }

  buildGrid() {
    return coreListModel == null
        ? Container()
        : StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: <Widget>[
        ...coreListModel!.expand((value) => [
          StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: value.coreSerial!.length % 2 == 0 ? 1.3 : 1.0,
              child: value.coreSerial!.length % 2 == 0
                  ? TaskGroupContainer(
                            color: Colors.pink,
                            icon: Icons.rocket_launch,
                            reuseCount: value.reuseCount!,
                            taskGroup: value.coreSerial ?? "",
                            routeVariable: value.coreSerial!,
                          )
                  : TaskGroupContainer(
                            color: Colors.orange,
                            isSmall: true,
                            icon: Icons.rocket_launch_outlined,
                            reuseCount: value.reuseCount!,
                            taskGroup:  value.coreSerial ?? "",
                            routeVariable: value.coreSerial!,
                          ),
            ),
      ]),
      ]
    );
  }


}
