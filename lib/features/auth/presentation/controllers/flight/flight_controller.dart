import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/util/device/device_utility.dart';
import '../../../data/models/airport_model.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/trip/trip_repository.dart';
import '../../../domain/services/flight_services.dart';
import '../../../domain/services/location_services.dart';
import '../../views/flight/widgets/class_selection_sheet.dart';
import '../../views/flight/widgets/passenger_selection_sheet.dart';
import '../../views/trips/create_trip/create_trip_detail/widgets/create_attraction_selection_sheet.dart';


class FlightController extends GetxController {

  static FlightController get instance => Get.find();

  GlobalKey<FormState> flightFormKey = GlobalKey<FormState>();
  // Controller
  // final originController = TextEditingController();
  // final destinationController = TextEditingController();
  final originController = TextEditingController();
  final destinationController = TextEditingController();
  final departureDateController = TextEditingController();
  final returnDateController = TextEditingController();
  final flightClassController = TextEditingController();
  final passengerController = TextEditingController();

  // Services
  final flightServices = Get.put(FlightServices());
  final locationServices = Get.put(LocationServices());

  RxBool isLoading = RxBool(false);

  String locationId = "";
  String locationName = "";
  String iatacode = "";

  var adultCount = 1.obs;
  var childCount = 0.obs;
  var babyCount = 0.obs;
  RxList<FlightModel> flights = <FlightModel>[].obs;
  RxList<AirportModel> airports = <AirportModel>[].obs;

  @override
  void onInit() {
    clearData();
    super.onInit();
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    departureDateController.dispose();
    returnDateController.dispose();
    flightClassController.dispose();
    passengerController.dispose();
    flights.clear();
    airports.clear();
    super.dispose();
  }

  void clearData() {
    flights.clear();
    airports.clear();
  }

  /// Fetch all attractions of the user
  void fetchFlightResult() async {
    try {
      isLoading.value = true;
      String origin = originController.text;
      String destination = destinationController.text;
      String departureDate = departureDateController.text;
      String returnDate = returnDateController.text;
      int adults = adultCount.value;
      int child = childCount.value;
      int baby = babyCount.value;
      String travelClass = "ECONOMY";

      switch(flightClassController.value){
        case ("First Class"):
          travelClass = "FIRST";
          break;
        case ("Business Class"):
          travelClass = "BUSINESS";
          break;
        case ("Economy Class"):
          travelClass = "ECONOMY";
          break;
      }
      bool nonStop = true;
      // Fetch trips
      final flightsResult = await flightServices.fetchData(origin, destination, departureDate, returnDate, adults, child, baby, travelClass, nonStop);

      // Assign attractions
      flights.assignAll(flightsResult);

      isLoading.value = false;
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Fetch nearest airport of the user
  Future<void> fetchNearestAirport(double lat, double lng) async {
    try {
      isLoading.value = true;

      if(airports.isNotEmpty){
        airports.clear();
      }

      // Fetch airport
      final airport = await flightServices.fetchAirport(lat, lng);

      // Assign attractions
      airports.assignAll(airport);

      isLoading.value = false;
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  /// Fetch flight recommendation for user
  Future<void> fetchFlightRecommendationResult(double lat, double lng, String origin, String departureDate, String returnDate) async {
    try {
      isLoading.value = true;
      int adults = 1;
      int child = 0;
      int baby = 0;
      String travelClass = "ECONOMY";
      bool nonStop = true;

      // Get the nearest airport of the location
      await fetchNearestAirport(lat, lng);
      String destination = airports[0].iataCode;

      // Fetch flights
      if(flights.isEmpty){
        final flightsResult = await flightServices.fetchData(origin, destination, departureDate, returnDate, adults, child, baby, travelClass, nonStop);

        // Assign attractions
        flights.assignAll(flightsResult);
      }
      isLoading.value = false;
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }

  void flightClassBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: ClassSelectionSheet(),
          );
        });
  }

  void flightPassengerBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: PassengerSelectionSheet(),
          );
        });
  }

  Future<void> selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = picked.toString().split(" ")[0];
    }
  }

  Future<String?> convertLocationToIATACode(SearchController controller) async {
    // Get lat lng of location
    Map<String, double> latlng = await locationServices.getPlaceLatLng(locationId);
    // Get nearby airport by latlng
    List<AirportModel> airport = await flightServices.fetchAirport(latlng['latitude']!, latlng['longitude']!);

    // Iata code of first result
    iatacode = airport[0].iataCode;
    print(iatacode);
    // Update controller text
    controller.text = iatacode;
    update();
  }

  void adultCountIncrement() {
    adultCount.value++;
    update();
  }

  void adultCountDecrement() {
    if(adultCount.value != 0){
      adultCount.value--;
    }
    update();
  }

  void childCountIncrement() {
    childCount.value++;
    update();
  }

  void childCountDecrement() {
    if(childCount.value != 0){
      childCount.value--;
    }
    update();
  }

  void babyCountIncrement() {
    babyCount.value++;
    update();
  }

  void babyCountDecrement() {
    if(babyCount.value != 0){
      babyCount.value--;
    }
    update();
  }
}