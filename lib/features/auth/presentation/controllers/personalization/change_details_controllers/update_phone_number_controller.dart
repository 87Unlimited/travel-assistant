import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/repositories/user/user_repository.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/profile/profile_view.dart';

import '../../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../../core/network/network_manager.dart';
import '../../../../../../core/util/popups/full_screen_loader.dart';

class UpdatePhoneNumberController extends GetxController {
  static UpdatePhoneNumberController get instance => Get.find();

  final phoneNumber = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updatePhoneNumberFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializedPhoneNumber();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializedPhoneNumber() async {
    phoneNumber.text = userController.user.value.phoneNumber;
  }

  Future<void> updatePhoneNumber() async {
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
      if (!updatePhoneNumberFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Update user first and last name in Firebase
      Map<String, dynamic> phoneNumberJson = {'PhoneNumber': phoneNumber.text.trim()};
      await userRepository.updateSingleField(phoneNumberJson);

      // Update the Rx user value
      userController.user.value.phoneNumber = phoneNumber.text.trim();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(title: "Congratulations", message: "Your phone number has been updated.");

      // Move to Verify Email Screen
      Get.back();

    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}