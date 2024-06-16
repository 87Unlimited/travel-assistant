import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_assistant/common/widgets/loaders/loaders.dart';
import 'package:travel_assistant/core/util/popups/full_screen_loader.dart';
import 'package:travel_assistant/features/auth/data/repositories/authentication/authentication_repository.dart';
import 'package:travel_assistant/features/auth/data/repositories/user/user_repository.dart';
import 'package:travel_assistant/features/auth/data/models/user_model.dart';

import '../../../../../core/network/network_manager.dart';
import '../../views/register/verify_email/verify_email_view.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Sign up account
  void signup() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "We are processing your information...",
          "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        CustomLoaders.warningSnackBar(
          title: "Accept Privacy Policy",
          message:
          "In order to create account, you must have to read and accept the Privacy Policy",
        );
        return;
      }

      // Register user in the Firebase Authentication % Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential!.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        userName: userName.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: "",
        preferences: "",
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(
          title: "Congratulations",
          message: "Your account has been created! Verify email to continue"
      );

      Timer.periodic(Duration(seconds: 2), (timer) {
        // Move to Verify Email Screen
        Get.offAll(() => VerifyEmailView(email: email.text.trim()));
        timer.cancel();
      });
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      print(e);
    } finally {
      // Remove Loader
      FullScreenLoader.stopLoading();
    }
  }
}