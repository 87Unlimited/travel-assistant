import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/models/day_model.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/util/formatters/formatter.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../../../navigation_menu.dart';
import '../../../data/models/location_model.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/trip/trip_repository.dart';
import '../../views/trips/create_trip/create_trip_detail/create_trip_detail_view.dart';

class CreateTripController extends GetxController {
  static CreateTripController get instance => Get.find();

  // Variables
  final location = SearchController();
  final tripName = TextEditingController();

  List<DateTime?> dates = [];
  String locationId = "";
  String locationName = "";
  GlobalKey<FormState> createTripFormKey = GlobalKey<FormState>();

  final user = AuthenticationRepository.instance.authUser;
  final navController = Get.put(NavigationController());

  List<DateTime> getAllDatesInRange(DateTime startDate, DateTime endDate) {
    List<DateTime> allDates = [];

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
      allDates.add(currentDate);
      currentDate = currentDate.add(Duration(days: 1));
    }

    print(allDates);
    return allDates;
  }

  // Save trip to Firebase
  Future<void> saveTripRecord() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Creating trip...",
          "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Date picker validation
      if (dates.length != 2) {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(title: "Oh Snap!", message: "Please select start date and last date.");
        return;
      }

      // Destination validation
      if (locationId == "") {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(title: "Oh Snap!", message: "Please enter destination.");
        return;
      }

      // Form Validation
      if (!createTripFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      List<Timestamp?> timestampList = CustomFormatters.convertDateTimeListToTimestamps(dates);

      final newTrip = TripModel(
        userId: user!.uid,
        tripName: tripName.text.trim(),
        location: LocationModel(locationId: locationId, locationName: locationName),
        description: '',
        image: '',
        startDate: timestampList[0],
        endDate: timestampList[1],
      );

      final tripRepository = Get.put(TripRepository());
      String documentId = await tripRepository.saveTripRecordAndReturnId(newTrip);

      List<DateTime> allDates = getAllDatesInRange(dates[0]!, dates[1]!);
      List<Timestamp?> allDatesTimestampList = CustomFormatters.convertDateTimeListToTimestamps(allDates);

      for (var i = 0; i < allDatesTimestampList.length; i++) {
        final day = DayModel(
          tripId: documentId,
          date: allDatesTimestampList[i],
        );

        await tripRepository.saveDaysRecord(day);
      }

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(title: "Trip created!", message: "You can create your own journey now!");

      // Redirect to reset password view
      // navController.selectedIndex.value = 2;
      Get.to(() => CreateTripDetailView(trip: newTrip,));
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      print(e.toString());
    }
  }
}