import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/custom_shapes/rounded_container.dart';
import 'package:travel_assistant/common/widgets/images/rounded_image.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/shadows.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/device/device_utility.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/data/models/attraction_model.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/trips/create_trip_controller.dart';
import 'package:travel_assistant/features/auth/presentation/controllers/trips/create_trip_detail_controller.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../../common/widgets/icons/text_with_icon.dart';
import '../../../../../controllers/google_map/google_map_controller.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.attraction,
    this.delete,
    required this.controller,
  });

  final AttractionModel attraction;
  final VoidCallback? delete;
  final CreateTripDetailController controller;

  @override
  Widget build(BuildContext context) {
    final customGoogleMapController = Get.put(CustomGoogleMapController());

    return GestureDetector(
        onTap: () async {
          LatLng latlng = await controller.getLatlng(attraction.location!.locationId);
          await customGoogleMapController.goToPlace(latlng);
        },
        child: Container(
          width: 400,
          height: 130,
          padding: const EdgeInsets.all(1),
          child: RoundedContainer(
            height: 10,
            child: Padding(
              padding: const EdgeInsets.all(CustomSizes.md),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TripCardTitleText(
                        title: attraction.attractionName,
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(color: CustomColors.secondary),
                      ),
                      const SizedBox(
                        height: CustomSizes.spaceBtwItems / 2,
                      ),
                      TextWithIcon(
                        icon: Iconsax.location,
                        title: attraction.location!.locationName,
                        color: CustomColors.grey,
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: CustomColors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ));
  }
}
