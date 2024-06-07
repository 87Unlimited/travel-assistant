import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceUtils {
  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(Get.context!).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(Get.context!).size.height;
  }
}