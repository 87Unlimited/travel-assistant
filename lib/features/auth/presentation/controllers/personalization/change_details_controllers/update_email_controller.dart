import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/repositories/user/user_repository.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/profile/profile_view.dart';

import '../../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../../core/network/network_manager.dart';
import '../../../../../../core/util/popups/full_screen_loader.dart';

class UpdateEmailController extends GetxController {
  static UpdateEmailController get instance => Get.find();

  final email = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializedEmail();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializedEmail() async {
    email.text = userController.user.value.firstName;
  }

  Future<void> updateUserEmail() async {
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
      if (!updateUserNameFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Update user first and last name in Firebase
      // Map<String, dynamic> name = {'Email': email.text.trim(), 'LastName': lastName.text.trim()};
      // await userRepository.updateSingleField(name);

      // Update the Rx user value
      // userController.user.value.firstName = firstName.text.trim();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(title: "Congratulations", message: "Your name has been updated.");

      // Move to Verify Email Screen
      Get.to(() => const ProfileView());

    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      // Remove Loader

    }
  }
}