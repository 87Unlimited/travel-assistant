import 'package:flutter/material.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';

class ShadowStyle {
  static const verticalCardShadow = BoxShadow(
    color: Colors.black,
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );

  static final horizontalCardShadow = BoxShadow(
    color: CustomColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2),
  );
}