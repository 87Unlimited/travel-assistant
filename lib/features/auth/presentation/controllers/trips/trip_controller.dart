import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/trip/trip_repository.dart';
import '../../views/profile/re_auth_user_form/re_auth_user_form.dart';

class TripController extends GetxController {
  static TripController get instance => Get.find();

  final isLoading = false.obs;
  final tripRepository = Get.put(TripRepository());
  RxList<TripModel> homeViewTrips = <TripModel>[].obs;
  Rx<TripModel> trip = TripModel.empty().obs;

  @override
  void onInit() {
    fetchHomeViewTrips();
    super.onInit();
  }

  /// Fetch all trips of the user
  void fetchHomeViewTrips() async {
    try {
      // Show loader when loading trips
      isLoading.value = true;

      // Fetch trips
      final trips = await tripRepository.getHomeViewTrips();

      // Assign trips
      homeViewTrips.assignAll(trips);
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}