import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/common/widgets/loaders/animation_loader.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: HelperFunctions.isDarkMode(Get.context!) ? CustomColors.dark : CustomColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250,),
              AnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}