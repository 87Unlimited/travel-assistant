import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/custom_shapes/rounded_container.dart';
import 'package:travel_assistant/common/widgets/images/rounded_image.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/shadows.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/core/util/device/device_utility.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/data/models/activity_model.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../../../../common/widgets/icons/text_with_icon.dart';
import '../../../../../../../../core/util/constants/image_strings.dart';
import '../../../../../../data/models/trip_model.dart';
import '../../../../../controllers/recommendation/recommendation_controller.dart';
import '../../../../activity/activity_view.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.activity,
    required this.trip,
    required this.controller,
  });

  final TripModel trip;
  final ActivityModel activity;
  final RecommendationController controller;

  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () async {
        String address = await controller.getActivitiesAddress(activity);
        Get.to(ActivityView(trip: trip, activity: activity, address: address,));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: CustomSizes.spaceBtwItems),
        child: Container(
          width: 200,
          height: 270,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
            color: dark ? CustomColors.darkGrey : CustomColors.white,
          ),
          child: Column(
            children: [
              RoundedContainer(
                padding: const EdgeInsets.all(CustomSizes.sm),
                backgroundColor: dark ? CustomColors.darkGrey : CustomColors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Center(
                      child: Stack(
                        children: [
                          // Image
                          RoundedImage(
                            imageUrl: activity.picture,
                            isNetworkImage: true,
                            applyImageRadius: true,
                            height: 130,
                          ),
                          // Tag
                          Positioned(
                            left: 0,
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
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 4,),

                    // Trip title
                    Text(
                      activity.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.primary),
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 4,),

                    activity.rating == 0.0 ? Text(
                      "No Rating Yet",
                      style: Theme.of(context).textTheme.titleLarge!.apply(color: CustomColors.grey),
                    ) :
                    RatingBar.builder(
                      initialRating: activity.rating!,
                      minRating: 0,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (BuildContext context, int index) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onRatingUpdate: (double value) {  },
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 4),

                    // Activity price
                    Text(
                        activity.price == 0.0 ? "Free" : '${activity.currencyCode} \$${activity.price.toString()}',
                      style: Theme.of(context).textTheme.headlineSmall!.apply(color: CustomColors.secondary),
                    ),
                    const SizedBox(height: CustomSizes.spaceBtwItems / 4,),

                    // Location with icon
                    Text(
                      activity.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.grey),
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
