import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobtora/src/meta/ui/themes/app_colors.dart';

class AppFonts {
  AppFonts._();

  static const String regular = 'ProductSansRegular';
  static const String medium = 'ProductSansMedium';
  static const String bold = 'ProductSansBold';
  static const String openSans = 'OpenSansRegular';
}

class TextStyles {
  TextStyles._();

  static const TextStyle normalTextStyle = TextStyle(
    color: AppColors.textGrey,
    fontSize: 15,
    fontFamily: AppFonts.medium,
  );

  static const TextStyle normalTextStyleDarker = TextStyle(
    color: Color(0xff757575),
    fontSize: 13.5,
    letterSpacing: 0.45,
    fontFamily: AppFonts.bold,
  );

  static const TextStyle normalTextStyleBlue = TextStyle(
    color: AppColors.mainBlue,
    fontSize: 15,
    fontFamily: AppFonts.medium,
  );

  static const TextStyle bigHeaderTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.darkBlue,
      fontSize: 19,
      letterSpacing: 0.3,
      fontFamily: AppFonts.bold);

  static const TextStyle smallHeaderTextStyle = TextStyle(
      color: AppColors.darkBlue,
      fontSize: 15.5,
      letterSpacing: 0.4,
      fontFamily: AppFonts.bold,
      fontWeight: FontWeight.w600);
}
