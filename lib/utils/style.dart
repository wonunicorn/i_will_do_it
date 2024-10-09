
import 'package:flutter/material.dart';
import 'package:i_will_do_it/utils/colors.dart';

extension AppTextStyle on TextStyle{

  static const TextStyle header38 = TextStyle(
    color: AppColors.blueColor,
    fontFamily: "Roboto",
    fontWeight: FontWeight.w700,
    fontSize: 38,
    height: 44.53 / 38
  );

  static const TextStyle header34 = TextStyle(
      color: AppColors.whiteColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 39.84 / 32
  );

  static const TextStyle header28 = TextStyle(
      color: AppColors.blueColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w700,
      fontSize: 28,
      height: 32.81 / 28
  );

  static const TextStyle text17 = TextStyle(
      color: AppColors.whiteColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 17,
      height: 25.5 / 17
  );

  static const TextStyle text22 = TextStyle(
      color: AppColors.blueColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w700,
      fontSize: 22,
      height: 25.78 / 22
  );

  static const TextStyle text20 = TextStyle(
      color: AppColors.darkBlackColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 21 / 20
  );

  static const TextStyle boldText600 = TextStyle(
      color: AppColors.darkBlackColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 21 / 16
  );

  static const TextStyle upperCaseText = TextStyle(
      color: AppColors.blueColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w700,
      fontSize: 20,
      height: 18 / 20
  );

  static const TextStyle thinText12 = TextStyle(
      color: AppColors.whiteColor,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 14 / 12
  );
}