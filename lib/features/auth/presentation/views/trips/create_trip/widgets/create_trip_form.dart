import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/validators/validation.dart';

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
                locationServices.placeAutoComplete(value, "country");
              } else {
                locationServices.placePredictions.clear();
              }
            },
            suggestionsBuilder: (BuildContext context, SearchController location) {
              return Iterable<Widget>.generate(
                  locationServices.placePredictions.length, (int index) {
                return LocationListTile(
                  location: locationServices.placePredictions[index].description,
                  onPressed: () async {
                    location.closeView(locationServices.placePredictions[index].description!);
                    controller.locationId = locationServices.placePredictions[index].placeId!;
                    controller.locationName = locationServices.placePredictions[index].description!;
                  },
                );
              });
            },
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Trip Title
          const SectionHeading(title: "Trip Name", showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

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