import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_assistant/config/theme/custom_theme/checkbox_theme.dart';
import 'package:travel_assistant/config/theme/custom_theme/outlined_button_theme.dart';
import 'package:travel_assistant/config/theme/custom_theme/text_field_theme.dart';
import 'package:travel_assistant/config/theme/custom_theme/text_theme.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';

import 'custom_theme/appbar_theme.dart';
import 'custom_theme/elevated_button_theme.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    textTheme: CustomTextTheme.lightTextTheme,
    scaffoldBackgroundColor: CustomColors.whiteSmoke,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.lightCheckboxTheme,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade100,
      primary: const Color(0xff002147),
      secondary: const Color(0xff1bc9f4),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    textTheme: CustomTextTheme.darkTextTheme,
    scaffoldBackgroundColor: Colors.blue[1000],
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    inputDecorationTheme: CustomTextFormFieldTheme.darkCheckboxTheme,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff002147),
      secondary: Color(0xff1bc9f4),
    ),
  );
}