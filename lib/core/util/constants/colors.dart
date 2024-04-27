import 'package:flutter/material.dart';

class CustomColors{
  CustomColors._();

  // App Colors
  static const Color primary = Color(0xff002147);
  static const Color secondary = Color(0xff3bcce5);

  static const Color dark = Color(0xff222222);
  static const Color white = Color(0xffffffff);

  // Gradient Colors
  static const Gradient linerGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
      Color(0xff1bc9f4),
      Color(0xff3bcce5),
      Color(0xffffffff),
    ],
  );

  // Text Colors
  static const Color textPrimary = Color(0xff2c3e64);
  static const Color textSecondary = Color(0xff2c3e64);
  static const Color textHint = Colors.grey;

  // Background
  static const Color lightBackground = Color(0xfff6f6f6);
  static const Color darkBackground = Color(0xff272727);

  static const Color grey = Color(0xff999999);
  static const Color lightGrey = Color(0xffDDDDDD);
  static const Color darkGrey = Color(0xff222222);
  static const Color whiteSmoke = Color(0xffF5F5F5);
}