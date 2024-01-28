import 'package:arch_challenge/core/utils/colors.dart';
import 'package:arch_challenge/core/utils/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyle {
  static TextStyle textXSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 13.sp,
    height: 1.57,
    color: Colors.white,
  );
  static TextStyle linkXSmall = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    height: 1.14,
    color: AppColors.primaryActive,
  );

  static TextStyle white18Style = TextStyle(
    color: Colors.white,
    // fontFamily: generalFont,
    fontSize: 18.sp,
    height: 1,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle boldText = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 24.sp,
    height: 1.14,
    color: AppColors.body,
  );

  static TextStyle light14Style = TextStyle(
    color: Colors.white,
    // fontFamily: generalFont,
    fontSize: 13.sp,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
  static TextStyle dark18Style = TextStyle(
    color: const Color(0xFF242424),
    fontFamily: FontFamily.hankenGrotesk,
    fontSize: 18.sp,
    height: 1.2,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
  );

  static TextStyle dark16Style = TextStyle(
    color: AppColors.body,

    // fontFamily: generalFont,
    fontSize: 16.sp,
    height: 1.3,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle dark14Style = TextStyle(
    color: AppColors.body,

    // fontFamily: generalFont,
    fontSize: 14.sp,
    height: 1,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle title = TextStyle(
    color: AppColors.body,
    fontSize: 24.sp,
    height: 1.3,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
  );

  static TextStyle browText = TextStyle(
    color: AppColors.body,
    fontFamily: FontFamily.hankenGrotesk,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
}
