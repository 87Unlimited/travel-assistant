import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/validators/validation.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';

import '../../../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../../../../common/widgets/section_heading.dart';
import '../../../../../../../core/util/constants/sizes.dart';
import '../../../../../data/models/location_model.dart';
import '../../../../../data/models/trip_model.dart';
import '../../../../../domain/services/location_services.dart';
import '../../../../controllers/trips/create_trip_controller.dart';
import '../calendar_config.dart';
import 'location_list_tile.dart';

class CreateTripForm extends StatelessWidget {
  const CreateTripForm({Key? key, this.trip}) : super(key: key);

  final TripModel? trip;

  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripController());
    final locationServices = Get.put(LocationServices());
    final textController = TextEditingController();

    if (trip != null) {
      controller.setTrip(trip!);
      controller.isTripExisted = true;
    }

    return Form(
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CalendarDatePicker2(
                config: CalendarConfig.getConfig(),
                value: controller.defaultDates,
                onValueChanged: (dates) => controller.defaultDates = dates,
              ),
              Image.network('https://maps.googleapis.com/maps/api/place/photo?maxheight=300&photoreference=AUGGfZkBHpwzn-E4mlQ_T3yYSSOUXXbD5VH4WSGcruHcqnLxVW61T506D0fsTDlA1Nmyo16QU3YfiL756RIDbi3sPpfldsL99xj2MxwHylyQvdM2tVLuU8L8OHbI6ukbP1YWPrYrD6n0n_-FJ-y-8x50GHOJriq0rNVyUeNbyk9gJzxiqzVK&key=AIzaSyAxXKd8jrvNtlfQIV4kpY3y5GRk5fRMczY')
            ],
          ),
          const SizedBox(height: CustomSizes.spaceBtwSections),

          // Location Title
          const SectionHeading(title: "Destination", showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Search Bar
          LocationSearchBar(
            controller: controller.location,
            leadingIcon: const Icon(Iconsax.location),
            trailingIcon: [
              IconButton(
                onPressed: () {print(controller.location.text.trim());},
                icon: const Center(
                  child: Icon(
                    CupertinoIcons.paperplane,
                  ),
                ),
              )
            ],
            hintText: controller.isTripExisted ? controller.location.text.toString() : "Search Country/Region",
            viewOnChanged: (value) {
              if (value != "") {
                locationServices.placeAutoComplete(value, "locality");
              } else {
                locationServices.placePredictions.clear();
              }
            },
            suggestionsBuilder:
                (BuildContext context, SearchController location) async {
              return Iterable<Widget>.generate(
                  locationServices.placePredictions.length, (int index) {
                return LocationListTile(
                  location:
                      locationServices.placePredictions[index].description,
                  onPressed: () async {
                    location.closeView(
                        locationServices.placePredictions[index].description!);
                    controller.locationId =
                        locationServices.placePredictions[index].placeId!;
                    controller.locationName =
                        locationServices.placePredictions[index].description!;

                  },
                );
              });
            },
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Trip Title
          const SectionHeading(title: "Trip Name", showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // GooglePlacesAutoCompleteTextFormField(
          //     textEditingController: textController,
          //     googleAPIKey: "AIzaSyAxXKd8jrvNtlfQIV4kpY3y5GRk5fRMczY",
          //     debounceTime: 400, // defaults to 600 ms
          //     countries: ["de"], // optional, by default the list is empty (no restrictions)
          //     isLatLngRequired: true, // if you require the coordinates from the place details
          //     getPlaceDetailWithLatLng: (prediction) {
          //       // this method will return latlng with place detail
          //       print("Coordinates: (${prediction.lat},${prediction.lng})");
          //     }, // this callback is called when isLatLngRequired is true
          //     itmClick: (prediction) {
          //       textController.text = prediction.description!;
          //       textController.selection = TextSelection.fromPosition(TextPosition(offset: prediction.description!.length));
          //     }
          // ),

          // Trip Form Field
          TextFormField(
            controller: controller.tripName,
            validator: (value) => Validator.validateEmptyText("Trip name", value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.location),
              labelText: "Trip Name",
            ),
            onChanged: (value) {
              locationServices.placeAutoComplete(value, "country");
            },
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          Center(
            child: SizedBox(
              width: CustomSizes.buttonWidth,
              height: CustomSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () => controller.isTripExisted ? controller.updateTripRecord() : controller.saveTripRecord(),
                child: Center(
                  child: Text(controller.isTripExisted ? 'Update Trip' : 'Create Trip'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}