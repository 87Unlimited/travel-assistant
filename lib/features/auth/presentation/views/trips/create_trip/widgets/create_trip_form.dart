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
import '../../../../controllers/trips/create_trip_controller.dart';
import '../calendar_config.dart';
import 'location_list_tile.dart';

class CreateTripForm extends StatelessWidget {
  const CreateTripForm({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripController());
    List<DateTime> _dates = [];

    return Form(
      key: controller.createTripFormKey,
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CalendarDatePicker2(
                config: CalendarConfig.getConfig(),
                value: _dates,
                onValueChanged: (dates) => controller.dates = dates,
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
            hintText: "Search Country/Region",
            viewOnChanged: (value) {
              if (value != "") {
                controller.placeAutoComplete(value);
              } else {
                controller.placePredictions.clear();
              }
            },
            suggestionsBuilder: (BuildContext context, SearchController location) {
              return Iterable<Widget>.generate(
                  controller.placePredictions.length, (int index) {
                return LocationListTile(
                  location: controller.placePredictions[index].description,
                  onPressed: () {
                    location.closeView(controller.placePredictions[index].description!);
                    controller.location.text =
                    controller.placePredictions[index].description!;
                    print(controller.location.text);
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
              controller.placeAutoComplete(value);
            },
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          Center(
            child: SizedBox(
              width: CustomSizes.buttonWidth,
              height: CustomSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () => controller.saveTripRecord(),
                child: const Center(
                  child: Text('Create Trip'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}