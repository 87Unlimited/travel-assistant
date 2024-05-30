import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/custom_shapes/rounded_container.dart';
import 'package:travel_assistant/common/widgets/images/rounded_image.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/shadows.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/device/device_utility.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/data/models/attraction_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../../common/widgets/icons/text_with_icon.dart';


class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.attraction,
    required this.delete,
  });

  final AttractionModel attraction;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        boxShadow: [ShadowStyle.horizontalCardShadow],
        borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
        color: Colors.white,
      ),
      child: RoundedContainer(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(CustomSizes.md),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TripCardTitleText(
                        title: attraction.attractionName,
                        textStyle: Theme.of(context).textTheme.headlineSmall!,
                      ),

                      const Spacer(),

                      Flexible(
                        child: IconButton(
                          onPressed: delete,
                          icon: Icon(Icons.delete, color: Colors.red,),
                        ),
                      )
                    ],
                  ),

                  TextWithIcon(
                    icon: Iconsax.clock,
                    title: "${attraction.startTime.values} - ${attraction.endTime.values}",
                    color: CustomColors.grey,
                    textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                  ),
                  SizedBox(height: CustomSizes.spaceBtwItems / 2,),

                  TextWithIcon(
                    icon: Iconsax.location,
                    title: attraction.location!.locationName,
                    color: CustomColors.grey,
                    textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                  ),
                ],
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
