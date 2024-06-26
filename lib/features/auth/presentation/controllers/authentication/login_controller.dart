import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/trips/trip_controller.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../home_controller.dart';

class LoginController extends GetxController {

  // Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  // Prepare for the home page info
  final homeController = Get.put(HomeController());

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  // Email and password sign-in
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Logging in...",
          "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Save data if remember me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Register user in the Firebase Authentication % Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
          email.text.trim(), password.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Prepare for the home page info
      // await homeController.fetchHomeViewData();

      // Move to Verify Email Screen
      AuthenticationRepository.instance.screenRedirect();

    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  // Google sign-in
  Future<void> googleSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Logging in...",
          "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Google authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // Save user record
      await userController.saveUserRecord(userCredentials);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}