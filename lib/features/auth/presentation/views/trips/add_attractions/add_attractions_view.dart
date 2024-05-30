import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/device/device_utility.dart';
import '../../../../../../../../core/util/validators/validation.dart';
import '../../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../domain/services/location_services.dart';
import '../../../controllers/trips/create_trip_detail_controller.dart';
import '../create_trip/widgets/location_list_tile.dart';

class AddAttractionView extends StatelessWidget {
  const AddAttractionView({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripDetailController());
    final locationServices = Get.put(LocationServices());
    var abbreviation = "";
    TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithNormalHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DeviceUtils.getScreenHeight(context),
                width: DeviceUtils.getScreenWidth(context),
                child: ListView(
                  children: <Widget>[
                    // Title and exit button
                    Row(
                      children: [
                        Expanded(
                          // Title
                          child: Text(
                            "Add Custom Attraction",
                            style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Exit Icon
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context)
                        ),
                      ],
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems),

                    Form(
                      key: controller.addAttractionFormKey,
                      child: Column(
                        children: [
                          Text(controller.selectedDate.toString() + trip.tripId!),

                          SectionHeading(title: "Location Details", showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Location Name Form Field
                          TextFormField(
                            controller: controller.attractionName,
                            validator: (value) => Validator.validateEmptyText("Trip name", value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.edit),
                              labelText: "Location Name",
                            ),
                            onChanged: (value) {
                              // controller.placeAutoComplete(value);
                            },
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Searcher for address, result restricted by the country
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
                            viewOnChanged: (value) async {
                              if (value != "") {
                                // Country abbreviation
                                abbreviation = await locationServices.getCountryAbbreviationByPlaceId(trip.location!.locationId);
                                // Restrict the result by the country that chosen by user
                                locationServices.placeAutoCompleteWithCountryRestrict(value, "", abbreviation);
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

                          SectionHeading(title: "Staying Time", showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Start time and end time selection
                          Row(
                            children: [
                              // Start time
                              Expanded(
                                child: ValueListenableBuilder<TimeOfDay>(
                                  valueListenable: controller.startTimeNotifier,
                                  builder: (context, startTime, _) {
                                    return TextFormField(
                                      controller: controller.startTime,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Iconsax.clock),
                                        labelText: "Start Time",
                                      ),
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: startTime,
                                        ).then((pickedTime) {
                                          if (pickedTime != null) {
                                            controller.updateStartTime(pickedTime);
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: CustomSizes.spaceBtwItems),

                              Text(
                                "To",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),

                              const SizedBox(width: CustomSizes.spaceBtwItems),

                              // End Time
                              Expanded(
                                child: ValueListenableBuilder<TimeOfDay>(
                                  valueListenable: controller.endTimeNotifier,
                                  builder: (context, endTime, _) {
                                    return TextFormField(
                                      controller: controller.endTime,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Iconsax.clock),
                                        labelText: "End Time",
                                      ),
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: endTime,
                                        ).then((pickedTime) {
                                          if (pickedTime != null) {
                                            controller.updateEndTime(pickedTime);
                                          }
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          SectionHeading(title: "Description", showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Description Form Field
                          TextFormField(
                            controller: controller.description,
                            validator: (value) => Validator.validateEmptyText("Description", value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Iconsax.edit),
                              labelText: "Description",
                            ),
                            maxLines: 5,
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwSections),

                          // Submit button
                          TextIconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: CustomSizes.iconMd,
                            ),
                            buttonText: 'Save Location To Trip',
                            onPressed: () async {
                              controller.saveAttractionRecord(trip.tripId!, controller.selectedDate!);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}