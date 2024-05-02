import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/repositories/user/user_repository.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  Future<void> logoutUser(UserCredential? userCredentials) async {
    try {
      if (userCredentials != null) {
        // Logout user
        await AuthenticationRepository.instance.logout();

        // Move to Verify Email Screen
        AuthenticationRepository.instance.screenRedirect();
      }
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}