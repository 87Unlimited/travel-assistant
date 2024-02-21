import 'package:flutter/material.dart';

import '../../../core/util/constants/colors.dart';

class CustomCheckboxTheme {
  CustomCheckboxTheme._();

  // Light button theme
  static final CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return CustomColors.primary;
      } else {
        return Colors.transparent;
      }
    }),
  );

  // Dark button theme
  static final CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return Colors.black;
      } else {
        return Colors.white;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected)){
        return Colors.white;
      } else {
        return Colors.transparent;
      }
    }),
  );
}