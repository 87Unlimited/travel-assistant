import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/models/day_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/trips_view.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/util/constants/sizes.dart';
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
  TripModel? trip = TripModel.empty();
  bool isTripExisted = false;

  List<DateTime?> defaultDates = [];
  String locationId = "";
  String locationName = "";

  // GlobalKey<FormState> createTripFormKey = GlobalKey<FormState>();
  RxList<DayModel> dayList = <DayModel>[].obs;

  final user = AuthenticationRepository.instance.authUser;
  final navController = Get.put(NavigationController());
  final tripRepository = Get.put(TripRepository());

  @override
  void onClose() {
    clearTrip();
    location.dispose();
    tripName.dispose();
    super.onClose();
  }

  void setTripText() {
    if (trip!.tripName.isNotEmpty) {
      tripName.text = trip!.tripName;
      location.text = trip!.location!.locationName;

      defaultDates = CustomFormatters.convertTimestampListToDateTime([trip!.startDate, trip!.endDate]);
    }
  }

  void setTrip(TripModel tripData) {
    trip = tripData;
    update();
    setTripText();
  }

  void clearTrip() {
    trip = TripModel.empty();
    tripName.text = "";
    location.text = "";
    isTripExisted = false;
    update();
  }

  List<DateTime> getAllDatesInRange(DateTime startDate, DateTime endDate) {
    List<DateTime> allDates = [];

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      allDates.add(currentDate);
      currentDate = currentDate.add(Duration(days: 1));
    }

    print(allDates);
    return allDates;
  }

  /// Save trip to Firebase
  Future<void> saveTripRecord() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Creating trip...", "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Date picker validation
      if (defaultDates.length != 2) {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
            title: "Oh Snap!",
            message: "Please select start date and last date.");
        return;
      }

      // Destination validation
      if (locationId == "") {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
            title: "Oh Snap!", message: "Please enter destination.");
        return;
      }

      // Form Validation
      // if (!createTripFormKey.currentState!.validate()) {
      //   // Remove Loader
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      List<Timestamp?> timestampList =
          CustomFormatters.convertDateTimeListToTimestamps(defaultDates);

      final newTrip = TripModel(
        userId: user!.uid,
        tripName: tripName.text.trim(),
        location:
            LocationModel(locationId: locationId, locationName: locationName),
        description: '',
        image: '',
        startDate: timestampList[0],
        endDate: timestampList[1],
      );

      final tripRepository = Get.put(TripRepository());
      String documentId = await tripRepository.saveTripRecordAndReturnId(newTrip);
      newTrip.tripId = documentId;

      List<DateTime> allDates =
          getAllDatesInRange(defaultDates[0]!, defaultDates[1]!);
      List<Timestamp?> allDatesTimestampList =
          CustomFormatters.convertDateTimeListToTimestamps(allDates);

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
      CustomLoaders.successSnackBar(
          title: "Trip created!",
          message: "You can create your own journey now!");

      clearTrip();

      // Redirect to CreateTripDetailView
      Get.to(() => CreateTripDetailView(trip: newTrip,));
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      print(e.toString());
    }
  }

  /// Update trip to Firebase
  Future<void> updateTripRecord() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Creating trip...", "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Date picker validation
      if (defaultDates.length != 2) {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
            title: "Oh Snap!",
            message: "Please select start date and last date.");
        return;
      }

      // Destination validation
      if (locationId == "") {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(
            title: "Oh Snap!", message: "Please enter destination.");
        return;
      }

      List<Timestamp?> timestampList =
          CustomFormatters.convertDateTimeListToTimestamps(defaultDates);

      final updatedTrip = TripModel(
        tripId: trip!.tripId,
        userId: user!.uid,
        tripName: tripName.text.trim(),
        location:
            LocationModel(locationId: locationId, locationName: locationName),
        description: '',
        image: '',
        startDate: timestampList[0],
        endDate: timestampList[1],
      );

      final tripRepository = Get.put(TripRepository());
      await tripRepository.updateTripDetails(updatedTrip);

      List<DateTime> allDates =
          getAllDatesInRange(defaultDates[0]!, defaultDates[1]!);
      List<Timestamp?> allDatesTimestampList =
          CustomFormatters.convertDateTimeListToTimestamps(allDates);

      // for (var i = 0; i < allDatesTimestampList.length; i++) {
      //   final day = DayModel(
      //     tripId: trip!.tripId,
      //     date: allDatesTimestampList[i],
      //   );
      //
      //   await tripRepository.saveDaysRecord(day);
      // }

      updateTripDates(defaultDates[0]!, defaultDates[1]!);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(
          title: "Trip Has Been Updated!",
          message: "You can create your own journey now!");

      clearTrip();

      // Redirect to CreateTripDetailView
      Get.to(() => CreateTripDetailView(trip: updatedTrip));
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      print(e.toString());
    }
  }

  /// Delete trip from Firebase
  Future<void> deleteTripRecord() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Creating trip...", "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      final tripRepository = Get.put(TripRepository());
      // Call tripRepository to remove trip
      await tripRepository.deleteTrip(trip!);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(
          title: "Trip Deleted!",
          message: "All data in the trip has been removed.");

      navController.selectedIndex.value = 2;
      Get.off(NavigationMenu());
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
      print(e.toString());
    }
  }

  /// Popup Warning dialog before deleting account
  void deleteTripWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(CustomSizes.md),
      title: "Delete Trip",
      middleText:
      "Are you sure to delete your trip permanently? This action is not reversible and all of your trip's data will be removed permanently.",
      confirm: ElevatedButton(
        onPressed: () async => deleteTripRecord(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: CustomSizes.lg), child: Text("Delete"),),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: CustomSizes.lg), child: Text("Cancle"),),
      ),
    );
  }

  void updateTripDates(DateTime newStartDate, DateTime newEndDate) {
    List<DateTime?> dateList = CustomFormatters.convertTimestampListToDateTime(
        [trip!.startDate, trip!.endDate]);
    DateTime? oldStartDate = dateList[0];
    DateTime? oldEndDate = dateList[1];

    // Check if start date or end date is changed
    bool isStartDateChanged = newStartDate != oldStartDate;
    bool isEndDateChanged = newEndDate != oldEndDate;

    // Handle start date changes
    if (isStartDateChanged) {
      // Identify added, deleted, and updated dates
      List<DateTime> addedDates =
          getAddedDates(newStartDate, newEndDate, oldStartDate!, oldEndDate!);
      List<DateTime> deletedDates =
          getDeletedDates(newStartDate, newEndDate, oldStartDate, oldEndDate);
      List<DateTime> updatedDates =
          getUpdatedDates(newStartDate, newEndDate, oldStartDate, oldEndDate);

      // Update Days collection for added dates
      for (DateTime date in addedDates) {
        createDaysDocument(date);
      }

      // Delete Days collection for deleted dates
      for (DateTime date in deletedDates) {
        getDaysDocument(date);
        deleteDaysDocument(date);
      }

      // // Update Days collection for updated dates
      for (DateTime date in updatedDates) {
        updateDaysDocument(date);
      }
    }

    // Handle end date changes (similar to start date changes)
    // if (isEndDateChanged) {
    //   // Identify added, deleted, and updated dates
    //   List<DateTime> addedDates =
    //       getAddedDates(newStartDate, newEndDate, oldStartDate!, oldEndDate!);
    //   List<DateTime> deletedDates =
    //       getDeletedDates(newStartDate, newEndDate, oldStartDate, oldEndDate);
    //   List<DateTime> updatedDates =
    //       getUpdatedDates(newStartDate, newEndDate, oldStartDate, oldEndDate);
    //
    //   // Update Days collection for added dates
    //   for (DateTime date in addedDates) {
    //     createDaysDocument(date);
    //   }
    //
    //   // Delete Days collection for deleted dates
    //   for (DateTime date in deletedDates) {
    //     deleteDaysDocument(date);
    //   }
    //
    //   // // Update Days collection for updated dates
    //   for (DateTime date in updatedDates) {
    //     updateDaysDocument(date);
    //   }
    // }

    // Update trip document with new dates
    updateTripDocument(newStartDate, newEndDate);
  }

  // Helper method to identify added dates
  List<DateTime> getAddedDates(DateTime newStartDate, DateTime newEndDate,
      DateTime oldStartDate, DateTime oldEndDate) {
    List<DateTime> addedDates = [];

    // Find added dates between new and old date range
    for (DateTime date = newStartDate;
        date.isBefore(newEndDate);
        date = date.add(const Duration(days: 1))) {
      if (date.isBefore(oldStartDate) || date.isAfter(oldEndDate)) {
        addedDates.add(date);
      }
    }

    return addedDates;
  }

// Helper method to identify deleted dates
  List<DateTime> getDeletedDates(DateTime newStartDate, DateTime newEndDate,
      DateTime oldStartDate, DateTime oldEndDate) {
    List<DateTime> deletedDates = [];

    // Find deleted dates between new and old date range
    for (DateTime date = oldStartDate;
        date.isBefore(oldEndDate);
        date = date.add(const Duration(days: 1))) {
      if (date.isBefore(newStartDate) || date.isAfter(newEndDate)) {
        deletedDates.add(date);
      }
    }

    return deletedDates;
  }

  // Helper method to identify updated dates
  List<DateTime> getUpdatedDates(DateTime newStartDate, DateTime newEndDate,
      DateTime oldStartDate, DateTime oldEndDate) {
    List<DateTime> updatedDates = [];

    // Find updated dates between new and old date range
    for (DateTime date = newStartDate;
        date.isBefore(newEndDate);
        date = date.add(const Duration(days: 1))) {
      if (!date.isBefore(oldStartDate) && !date.isAfter(oldEndDate)) {
        updatedDates.add(date);
      }
    }

    return updatedDates;
  }

// Helper method to create Days document for a date
  Future<void> createDaysDocument(DateTime date) async {
    // Logic to create Days document
    Timestamp? timestamp = CustomFormatters.convertDateTimeToTimestamps(date);

    final day = DayModel(
      tripId: trip!.tripId,
      date: timestamp,
    );

    await tripRepository.saveDaysRecord(day);
  }

  // Helper method to delete Days document for a date
  Future<void> deleteDaysDocument(DateTime date) async {
    // Logic to delete Days document
    Timestamp? timestamp = CustomFormatters.convertDateTimeToTimestamps(date);

    final day = DayModel(
      tripId: trip!.tripId,
      date: timestamp,
    );

    await tripRepository.deleteDaysRecord(day);
  }

  void getDaysDocument(DateTime date) async {
    try {
      // Transfer selectedDate to Timestamp
      Timestamp? selectedTimestamp = CustomFormatters.convertDateTimeToTimestamps(date);

      final day = DayModel(
        tripId: trip!.tripId,
        date: selectedTimestamp,
      );

      // Get the day model to fetch dayId
      List<DayModel> days = await tripRepository.getDaysRecord(day);

      print(days[0]);

    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

// Helper method to update Days document for a date
  void updateDaysDocument(DateTime date) {
    // Logic to update Days document
    // ...
  }

// Helper method to update trip document with new dates
  void updateTripDocument(DateTime newStartDate, DateTime newEndDate) {
    // Logic to update trip document
    // ...
  }
}
