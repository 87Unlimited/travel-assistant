import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../domain/services/location_services.dart';
import '../../views/trips/create_trip/widgets/location_list_tile.dart';
import '../trips/create_trip_controller.dart';

class SearchBarController extends GetxController {
  static SearchBarController get instance => Get.find();

  final controller = Get.put(CreateTripController());
  final locationServices = Get.put(LocationServices());
  final location = SearchController();

  @override
  void dispose() {
    location.dispose();
    super.dispose();
  }

  Future<void> loadSuggestions(String value, String type) async {
    locationServices.placeAutoComplete(value, type);
  }

  Future<Iterable<Widget>> buildSuggestions(BuildContext context, SearchController location) async {
    await Future.delayed(Duration(milliseconds: 300));

    List<Widget> suggestionWidgets = locationServices.placePredictions.map((
        prediction) {
      return LocationListTile(
        location: prediction.description,
        onPressed: () async {
          location.closeView(prediction.description!);
          controller.locationId = prediction.placeId!;
          controller.locationName = prediction.description!;
        },
      );
    }).toList();

    return suggestionWidgets;
  }
}