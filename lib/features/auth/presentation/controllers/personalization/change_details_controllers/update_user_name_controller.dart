import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/repositories/user/user_repository.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/personalization/user_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/profile/profile_view.dart';

import '../../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../../core/network/network_manager.dart';
import '../../../../../../core/util/popups/full_screen_loader.dart';

class UpdateUserNameController extends GetxController {
  static UpdateUserNameController get instance => Get.find();

  final userName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializedUserName();
    super.onInit();
  }

  // Fetch user record
  Future<void> initializedUserName() async {
    userName.text = userController.user.value.userName;
  }

  Future<void> updateUserName() async {
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
      Map<String, dynamic> userNameJson = {'UserName': userName.text.trim()};
      await userRepository.updateSingleField(userNameJson);

      // Update the Rx user value
      userController.user.value.userName = userName.text.trim();

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(title: "Congratulations", message: "Your user name has been updated.");

      // Move to Verify Email Screen
      Navigator.pop(Get.overlayContext!);

    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}