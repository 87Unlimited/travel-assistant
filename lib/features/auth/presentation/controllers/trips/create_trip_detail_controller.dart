import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/util/device/device_utility.dart';
import '../../../../../core/util/formatters/formatter.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/models/attraction_model.dart';
import '../../../data/models/day_model.dart';
import '../../../data/models/location_model.dart';
import '../../../data/repositories/trip/attraction_repository.dart';
import '../../../domain/services/location_services.dart';
import '../../views/trips/create_trip/create_trip_detail/widgets/create_attraction_selection_sheet.dart';
import '../google_map/google_map_controller.dart';

class CreateTripDetailController extends GetxController {
  static CreateTripDetailController get instance => Get.find();
  final locationServices = Get.put(LocationServices());
  final attractionRepository = Get.put(AttractionRepository());

  // Variables
  DateTime? selectedDate;
  String formattedDate = "";
  String tripId = "";
  TripModel trip = TripModel.empty();

  final isLoading = false.obs;

  final location = SearchController();
  final attractionName = TextEditingController();
  final description = TextEditingController();

  // Time picker variables
  final startTime = TextEditingController();
  final endTime = TextEditingController();
  ValueNotifier<TimeOfDay> startTimeNotifier = ValueNotifier<TimeOfDay>(TimeOfDay(hour: 8, minute: 0));
  ValueNotifier<TimeOfDay> endTimeNotifier = ValueNotifier<TimeOfDay>(TimeOfDay(hour: 9, minute: 0));

  String locationId = "";
  String locationName = "";
  GlobalKey<FormState> addAttractionFormKey = GlobalKey<FormState>();

  RxList<AttractionModel> attractionsOfSingleDay = <AttractionModel>[].obs;
  RxList<AttractionModel> allAttractions = <AttractionModel>[].obs;
  Rx<AttractionModel> attraction = AttractionModel.empty().obs;
  VoidCallback? onAttractionsChange;

  @override
  Future<void> onInit() async {
    await getAllAttractions();
    fetchAttractionsOfSingleDay(tripId);
    super.onInit();
  }


  @override
  void dispose() {
    attractionsOfSingleDay.clear();
    super.dispose();
  }

  void updateStartTime(TimeOfDay pickedTime) {
    startTimeNotifier.value = pickedTime;
    startTime.text = pickedTime.format(Get.overlayContext!);
  }

  void updateEndTime(TimeOfDay pickedTime) {
    endTimeNotifier.value = pickedTime;
    endTime.text = pickedTime.format(Get.overlayContext!);
  }

  // void checkAttractionsAndSetCameraPosition() {
  //   if (allAttractions.isEmpty) {
  //     final LatLng locationLatLng = LatLng(trip.location.latitude, trip.location.longitude);
  //     googleMapController.setCameraPosition(CameraPosition(target: locationLatLng, zoom: 12));
  //   }
  // }

  Future<LatLng> getLatlng(String placeId) async {
    Map<String, double> latlng = await locationServices.getPlaceLatLng(placeId);
    return LatLng(latlng['latitude']!, latlng['longitude']!);
  }

  /// Get All attractions from Firebase
  Future<void> getAllAttractions() async {
    allAttractions.clear();
    
    List<DateTime?> dateRange = CustomFormatters.convertTimestampListToDateTime([trip.startDate, trip.endDate]);

    dateRange = getAllDatesInRange(dateRange[0]!, dateRange[1]!);

    for (var date in dateRange) {
      // Transfer selectedDate to Timestamp
      Timestamp? dateTimestamp = CustomFormatters.convertDateTimeToTimestamps(date);

      // Get the day model to fetch dayId
      List<DayModel> day = await attractionRepository.fetchDay(trip.tripId!, dateTimestamp!);

      // Fetch trips
      final attractions = await attractionRepository.fetchAttractionsByDayId(tripId, day[0].dayId!);

      attractions.sort((a, b) => a.startTime.compareTo(b.startTime));

      // Assign attractions
      for (var attraction in attractions) {
        allAttractions.add(attraction);
      }
    }
  }

  /// Save Attraction to Firebase
  Future<void> saveAttractionRecord(String tripId, DateTime selectedDate) async {
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

      // // Destination validation
      if (locationId == "") {
        FullScreenLoader.stopLoading();
        CustomLoaders.errorSnackBar(title: "Oh Snap!", message: "Please enter destination.");
        return;
      }

      // Form Validation
      if (!addAttractionFormKey.currentState!.validate()) {
        // Remove Loader
        FullScreenLoader.stopLoading();
        return;
      }

      // Transfer selectedDate to Timestamp
      Timestamp? selectedTimestamp = CustomFormatters.convertDateTimeToTimestamps(selectedDate);

      final attractionRepository = Get.put(AttractionRepository());
      // Get the day model to fetch dayId
      List<DayModel> day = await attractionRepository.fetchDay(tripId, selectedTimestamp!);

      Timestamp? startTimeStamp = CustomFormatters.convertTimeOfDayToTimestamp(day[0], startTimeNotifier.value);
      Timestamp? endTimeStamp = CustomFormatters.convertTimeOfDayToTimestamp(day[0], endTimeNotifier.value);

      // Transfer startTime to Json value
      final startTimeJsonValue = {
        'hour': startTimeNotifier.value.hour,
        'minute': startTimeNotifier.value.minute,
      };

      // Transfer endTime to Json value
      final endTimeJsonValue = {
        'hour': endTimeNotifier.value.hour,
        'minute': endTimeNotifier.value.minute,
      };

      final attraction = AttractionModel(
        tripId: tripId,
        attractionName: attractionName.text.trim(),
        location: LocationModel(locationId: locationId, locationName: locationName),
        description: description.text.trim(),
        image: '',
        startTime: startTimeStamp,
        endTime: endTimeStamp,
      );

      // Save to the Firebase using dayId
      await attractionRepository.saveAttractionRecord(tripId, day[0].dayId!, attraction);

      await getAllAttractions();
      fetchAttractionsOfSingleDay(tripId);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(
          title: "Attraction has been saved!",
          message: "Add more attraction to have a better experience!"
      );

      // Redirect to create trip view
      Navigator.pop(Get.overlayContext!);
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Handle the selected day change
  void handleDateChange(DateTime changedDate) {
    selectedDate = changedDate;
    formattedDate = DateFormat('d, EEE').format(selectedDate!);
    fetchAttractionsOfSingleDay(tripId);
  }

  /// Fetch all attractions of the specific day
  void fetchAttractionsOfSingleDay(String tripId) async {
    try {
      // Show loader when loading trips
      isLoading.value = true;

      // Transfer selectedDate to Timestamp
      Timestamp? selectedTimestamp = CustomFormatters.convertDateTimeToTimestamps(selectedDate);

      // Get the day model to fetch dayId
      List<DayModel> day = await attractionRepository.fetchDay(tripId, selectedTimestamp!);

      // Fetch trips
      final attractions = await attractionRepository.fetchAttractionsByDayId(tripId, day[0].dayId!);

      attractions.sort((a, b) => a.startTime.compareTo(b.startTime));

      // Assign attractions
      attractionsOfSingleDay.assignAll(attractions);

      print(attractionsOfSingleDay.indexOf(1));
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete attraction from firebase
  void deleteAttraction(attractionId) async {
    try {
      // Show loader when loading trips
      isLoading.value = true;

      // Transfer selectedDate to Timestamp
      Timestamp? selectedTimestamp = CustomFormatters.convertDateTimeToTimestamps(selectedDate);

      // Get the day model to fetch dayId
      List<DayModel> day = await attractionRepository.fetchDay(tripId, selectedTimestamp!);

      await attractionRepository.deleteAttraction(tripId, day[0].dayId!, attractionId);

      // Fetch trips
      final attractions = await attractionRepository.fetchAttractionsByDayId(tripId, day[0].dayId!);

      // Assign attractions
      attractionsOfSingleDay.assignAll(attractions);

      await getAllAttractions();
      // Show error to the user
      CustomLoaders.successSnackBar(title: "Success", message: "");
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Calculate date range
  List<DateTime> getAllDatesInRange(DateTime startDate, DateTime endDate) {
    List<DateTime> allDates = [];

    DateTime currentDate = startDate;
    while (currentDate.isBefore(endDate) ||
        currentDate.isAtSameMomentAs(endDate)) {
      allDates.add(currentDate);
      currentDate = currentDate.add(Duration(days: 1));
    }
    return allDates;
  }

  /// Show Bottom sheet
  void tripBottomSheet(context, TripModel trip) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: CreateAttractionSelectionSheet(
              trip: trip,
            ),
          );
        });
  }
}