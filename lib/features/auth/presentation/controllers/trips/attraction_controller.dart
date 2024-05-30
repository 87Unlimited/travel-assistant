import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/features/auth/data/models/attraction_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/util/formatters/formatter.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/models/day_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/trip/attraction_repository.dart';
import '../../views/profile/re_auth_user_form/re_auth_user_form.dart';
import 'create_trip_detail_controller.dart';

class AttractionController extends GetxController {
  static AttractionController get instance => Get.find();

  final isLoading = false.obs;
  final attractionRepository = Get.put(AttractionRepository());
  final createTripDetailController = Get.put(CreateTripDetailController());

  RxList<AttractionModel> attractionsOfSingleDay = <AttractionModel>[].obs;
  Rx<AttractionModel> attraction = AttractionModel.empty().obs;

  @override
  void onInit() {
    fetchAttractionsOfSingleDay(createTripDetailController.tripId);
    super.onInit();
  }

  /// Fetch all attractions of the user
  void fetchAttractionsOfSingleDay(String tripId) async {
    try {
      // Show loader when loading trips
      isLoading.value = true;

      // Transfer selectedDate to Timestamp
      Timestamp? selectedTimestamp = CustomFormatters.convertDateTimeToTimestamps(createTripDetailController.selectedDate);

      // Get the day model to fetch dayId
      List<DayModel> day = await attractionRepository.fetchDay(tripId, selectedTimestamp!);

      // Fetch trips
      final attractions = await attractionRepository.fetchAttractionsByDayId(tripId, day[0].dayId!);

      // Assign attractions
      attractionsOfSingleDay.assignAll(attractions);
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Popup Warning dialog before deleting account
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(CustomSizes.md),
      title: "Delete Account",
      middleText:
      "Are you sure to delete your account permanently? This action is not reversible and all of your data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: CustomSizes.lg), child: Text("Delete"),),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text("Cancel"),
      ),
    );
  }

  /// Delete User account from Firebase
  void deleteUserAccount() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "We are processing your information...",
          "assets/animations/loading.json");

      // Update the Rx user value
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginView());
        } else if (provider == 'password') {
          FullScreenLoader.stopLoading();
          Get.offAll(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}