import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

import '../../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/device/device_utility.dart';
import '../../../../../../../../core/util/validators/validation.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';

class BottomSheetAddAttraction extends StatelessWidget {
  const BottomSheetAddAttraction({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripDetailController());

    return SingleChildScrollView(
      child: Padding(
        padding: SpacingStyle.paddingWithNormalHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: DeviceUtils.getScreenHeight(context) * .60,
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
                        Text(controller.selectedDate.toString()),

                        // Location Name Form Field
                        TextFormField(
                          // controller: controller.tripName,
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

                        TextFormField(
                          // controller: controller.tripName,
                          validator: (value) => Validator.validateEmptyText("Location Address", value),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Iconsax.location),
                            labelText: "Location Address",
                          ),
                          onChanged: (value) {
                            // controller.placeAutoComplete(value);
                          },
                        ),
                        const SizedBox(height: CustomSizes.spaceBtwItems),

                        // Start time and end time selection
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                // controller: controller.tripName,
                                validator: (value) => Validator.validateEmptyText("Staying Time", value),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.clock),
                                  labelText: "Start Time",
                                ),
                                onChanged: (value) {
                                  // controller.placeAutoComplete(value);
                                },
                              ),
                            ),
                            const SizedBox(width: CustomSizes.spaceBtwItems),

                            Text(
                              "To",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),

                            const SizedBox(width: CustomSizes.spaceBtwItems),

                            Expanded(
                              child: TextFormField(
                                // controller: controller.tripName,
                                validator: (value) => Validator.validateEmptyText("Staying Time", value),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.clock),
                                  labelText: "End Time",
                                ),
                                onChanged: (value) {
                                  // controller.placeAutoComplete(value);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: CustomSizes.spaceBtwSections),

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
    );
  }
}