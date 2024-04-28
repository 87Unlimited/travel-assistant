import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_assistant/common/widgets/loaders/loaders.dart';
import 'package:travel_assistant/core/util/popups/full_screen_loader.dart';
import 'package:travel_assistant/features/auth/data/repositories/authentication/authentication_repository.dart';
import 'package:travel_assistant/features/auth/data/repositories/user/user_repository.dart';
import 'package:travel_assistant/features/auth/domain/entities/user_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/register/verify_email/success_view.dart';

import '../../../../core/network/network_manager.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  /// Send Email when verify screen appears
  @override
  void onInit(){
    sendEmailVerification();
    super.onInit();
  }

  /// Send Email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      CustomLoaders.successSnackBar(title: "Email Sent", message: "Please check your inbox and verify your email.");
    } catch (e) {
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.off(
            () => SuccessView(
              image: "assets/animations/sammy-line-man-receives-a-mail.png",
              title: "Your account successfully created!",
              subTitle: "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!",
              onPressed: () => AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  /// Manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      print("success");
      Get.off(
        () => SuccessView(
          image: "assets/animations/sammy-line-man-receives-a-mail.png",
          title: "Your account successfully created!",
          subTitle:
              "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!",
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    } else {
      print("Failed ${currentUser?.emailVerified}");
    }
  }
}