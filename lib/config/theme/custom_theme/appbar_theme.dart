import 'package:flutter/material.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  // Light Appbar theme
  static const lightAppBarTheme = AppBarTheme(
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      foregroundColor: CustomColors.primary,
      iconTheme: IconThemeData(color: CustomColors.primary, size: CustomSizes.iconMd),
      actionsIconTheme: IconThemeData(color: CustomColors.primary, size: CustomSizes.iconMd),
      titleTextStyle: TextStyle(fontSize: 18, color: CustomColors.primary, fontWeight: FontWeight.w600),
  );

  // Dark Appbar theme
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    foregroundColor: CustomColors.primary,
    iconTheme: IconThemeData(color: CustomColors.primary, size: CustomSizes.iconMd),
    actionsIconTheme: IconThemeData(color: Colors.white, size: CustomSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
  );
}