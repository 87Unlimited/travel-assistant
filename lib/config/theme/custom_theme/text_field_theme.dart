import 'package:flutter/material.dart';

import '../../../core/util/constants/colors.dart';
import '../../../core/util/constants/sizes.dart';

class CustomTextFormFieldTheme {
  CustomTextFormFieldTheme._();

  // Light button theme
  static final InputDecorationTheme lightCheckboxTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

    labelStyle: const TextStyle().copyWith(fontSize: 14, color: CustomColors.primary),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: CustomColors.primary),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: CustomColors.primary.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.black12),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.redAccent),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.orange),
    ),
  );

  // Dark button theme
  static final InputDecorationTheme darkCheckboxTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,

    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.redAccent),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(CustomSizes.filedCircular),
      borderSide: const BorderSide(width: 1, color: Colors.orange),
    ),
  );
}