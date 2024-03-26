import 'package:flutter/material.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';

class CustomSearchBarTheme {
  CustomSearchBarTheme._();

  // Light button theme
  static final lightSearchBarTheme = SearchBarThemeData(
    elevation: MaterialStateProperty.all<double>(0.0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    hintStyle: MaterialStateProperty.all<TextStyle>(
      const TextStyle(
        color: CustomColors.grey,
      ),
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(
            fontSize: CustomSizes.fontSizeSm,
            color: CustomColors.primary,
            fontWeight: FontWeight.w600,
        )
    ),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder( borderRadius: BorderRadius.circular(CustomSizes.filedCircular)),
    ),

  );

  // Dark button theme
  static final darkSearchBarTheme = OutlinedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
          fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}