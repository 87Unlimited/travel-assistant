import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripStepperController extends GetxController {
  static TripStepperController get instance => Get.find();

  int index = 0;
  int groupValue = 0;
  StepperType type = StepperType.vertical;

  // void go(int index) {
  //   if (index == -1 && _index <= 0 ) {
  //     ddlog("it's first Step!");
  //     return;
  //   }
  //
  //   if (index == 1 && _index >= tuples.length - 1) {
  //     ddlog("it's last Step!");
  //     return;
  //   }
  //
  //   setState(() {
  //     _index += index;
  //   });
  // }
}