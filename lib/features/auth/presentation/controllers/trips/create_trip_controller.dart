import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/create_trip_detail.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/trips_view.dart';

import '../../../../../auth/secrets.dart';
import '../../../../../common/widgets/loaders/loaders.dart';
import '../../../../../core/network/network_manager.dart';
import '../../../../../core/network/network_utility.dart';
import '../../../../../core/util/formatters/formatter.dart';
import '../../../../../core/util/popups/full_screen_loader.dart';
import '../../../data/models/autocomplete_prediction.dart';
import '../../../data/models/place_auto_complete_response.dart';
import '../../../data/models/trip_model.dart';
import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/trip/trip_repository.dart';
import '../../../utilities/debounce.dart';
import '../../views/password_config/forget_password.dart';
import '../../views/password_config/reset_password.dart';
import '../../views/trips/create_trip/create_trip_detail/create_trip_detail_new.dart';

class CreateTripController extends GetxController {
  static CreateTripController get instance => Get.find();

  // Variables
  final location = SearchController();
  final tripName = TextEditingController();
  List<AutocompletePrediction> placePredictions = <AutocompletePrediction>[].obs;
  List<DateTime?> dates = [];
  GlobalKey<FormState> createTripFormKey = GlobalKey<FormState>();
  final user = AuthenticationRepository.instance.authUser;

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  void placeAutoComplete(String query) async {
    _debouncer.run(() {
      Uri uri = Uri.https("maps.googleapis.com",
          'maps/api/place/autocomplete/json',
          {
            "input": query!,
            "key": placesApiKey,
            "types": "country",
          });

      NetworkUtility.fetchUrl(uri).then((String? response) {
        if (response != null) {
          PlaceAutoCompleteResponse result = PlaceAutoCompleteResponse
              .parseAutoCompleteResult(response);
          if (result.predictions != null) {
            placePredictions = result.predictions!;
            print(response);
          }
        }
      });
    });
  }

  // Send reset password email
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
      if (location.text.trim() == "") {
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
        location: location.text.trim(),
        description: '',
        image: '',
        startDate: timestampList[0],
        endDate: timestampList[1],
      );

      final tripRepository = Get.put(TripRepository());
      await tripRepository.saveTripRecord(newTrip);

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show Success Message
      CustomLoaders.successSnackBar(title: "Trip created!", message: "You can create your own journey now!");

      // Redirect to reset password view
      Get.to(() => TripView());
    } catch (e) {
      // Remove Loader
      FullScreenLoader.stopLoading();
      // Show error to the user
      CustomLoaders.errorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}