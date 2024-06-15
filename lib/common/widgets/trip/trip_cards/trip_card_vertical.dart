import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/create_trip_detail_view.dart';

import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/image_strings.dart';
import '../../../../../../core/util/constants/shadows.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/helpers/helper_functions.dart';
import '../../custom_shapes/rounded_container.dart';
import '../../icons/circular_icon.dart';
import '../../icons/text_with_icon.dart';
import '../../images/rounded_image.dart';

class TripCard extends StatelessWidget {
  const TripCard({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => CreateTripDetailView(trip: trip,)),
      child: Padding(
        padding: const EdgeInsets.only(right: CustomSizes.spaceBtwItems),
        child: Container(
          height: 300,
          width: 200,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
            color: dark ? CustomColors.darkGrey : Colors.white,
          ),
          child: Column(
            children: [
              RoundedContainer(
                height: 230,
                padding: const EdgeInsets.all(CustomSizes.sm),
                backgroundColor: dark ? CustomColors.darkGrey : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Image
                        RoundedImage(
                          height: 150,
                          width: 200,
                          imageUrl: trip.image!,
                          applyImageRadius: true,
                          isNetworkImage: true,
                        ),
                        // Tag
                        Positioned(
                          left: 3,
                          child: RoundedContainer(
                            height: CustomSizes.lg,
                            padding: const EdgeInsets.symmetric(horizontal: CustomSizes.sm, vertical: CustomSizes.xs),
                            backgroundColor: Colors.transparent,
                            //child: tag != null ? Text(tag!, style: Theme.of(context).textTheme.labelLarge!.apply(color: Colors.white)) : null,
                          ),
                        ),

                        // Favourite Icon Button
                        const Positioned(
                          top: -5,
                          right: 0,
                          child: CircularIcon(icon: Iconsax.heart5, color: Colors.red, backgroundColor: Colors.transparent,),
                        )
                      ],
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 2,),
                    // Trip title
                    Text(
                      trip.tripName,
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 2,),
                    // Location with icon
                    TextWithIcon(
                      icon: Iconsax.location5,
                      title: trip.location!.locationName,
                      color: CustomColors.secondary,
                      textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}