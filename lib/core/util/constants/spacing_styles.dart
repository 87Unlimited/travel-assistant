import 'package:flutter/cupertino.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';

class SpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: CustomSizes.appBarHeight,
    left: CustomSizes.defaultSpace,
    bottom: CustomSizes.defaultSpace,
    right: CustomSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry paddingWithNormalHeight = EdgeInsets.only(
    top: CustomSizes.defaultSpace,
    left: CustomSizes.defaultSpace,
    bottom: CustomSizes.defaultSpace,
    right: CustomSizes.defaultSpace,
  );

  static const EdgeInsetsGeometry paddingHomeView = EdgeInsets.only(
    top: CustomSizes.appBarHeight,
  );

  static const EdgeInsetsGeometry loginPadding = EdgeInsets.only(
    top: 100,
    left: CustomSizes.defaultSpace,
    bottom: CustomSizes.defaultSpace,
    right: CustomSizes.defaultSpace,
  );
}