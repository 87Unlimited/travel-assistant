import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/formatters/formatter.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/trip/trip_repository.dart';
import '../../views/profile/re_auth_user_form/re_auth_user_form.dart';
import '../../views/trips/create_trip/create_trip_detail/create_trip_detail_view.dart';

class TripController extends GetxController {
  static TripController get instance => Get.find();

  final isLoading = false.obs;
  final tripRepository = Get.put(TripRepository());
  RxList<TripModel> homeViewTrips = <TripModel>[].obs;
  RxList<TripModel> upcomingTrips = <TripModel>[].obs;
  RxList<TripModel> pastTrips = <TripModel>[].obs;
  Rx<TripModel> trip = TripModel.empty().obs;
  RxList<FlightModel> upcomingFlights = <FlightModel>[].obs;

  @override
  Future<void> onInit() async {
    await fetchHomeViewTrips();
    super.onInit();
  }

  /// Fetch all trips of the user
  Future<void> fetchHomeViewTrips() async {
    try {
      // Show loader when loading trips
      isLoading.value = true;

      // Fetch trips
      // if(upcomingTrips.isEmpty && pastTrips.isEmpty){
      //   final trips = await tripRepository.getHomeViewTrips();
      //
      //   // Assign trips
      //   homeViewTrips.assignAll(trips);
      // }

      final trips = await tripRepository.getHomeViewTrips();

      // Assign trips
      homeViewTrips.assignAll(trips);

      DateTime currentDate = DateTime.now();

      List<TripModel> upcomingTripsList = [];
      List<TripModel> pastTripsList = [];

      // Assign upcoming trips
      for(var trip in homeViewTrips){
        DateTime startDate = trip.startDate!.toDate();
        if (startDate.isAfter(currentDate)) {
          upcomingTripsList.add(trip);
        } else {
          pastTripsList.add(trip);
        }
      }

      upcomingTrips.assignAll(upcomingTripsList);
      pastTrips.assignAll(pastTripsList);
      update();
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch all flight tickets of upcoming trip
  Future<void> fetchHomeViewFlights() async {
    try {
      // Show loader when loading trips
      isLoading.value = true;

      List<FlightModel> flights = [];

      for (var trip in homeViewTrips) {
        if (trip.flight!.flightNumber!.isNotEmpty) {
          flights.add(trip.flight!);
        }
      }

      upcomingFlights.assignAll(flights);

      update();
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Add Flight to Trips collection
  void addFlightToTrip(TripModel trip, FlightModel flight) async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          "Adding Flight To Your Trip...", "assets/animations/loading.json");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        return;
      }

      // Add flight
      tripRepository.addFlightToTripDocument(trip.tripId!, flight);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(
          title: "Flight Added!",
          message: "You can create your own journey now!");

      // Redirect to CreateTripDetailView
      Get.to(() => CreateTripDetailView(trip: trip, flight: flight,));
    } catch (e) {
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}