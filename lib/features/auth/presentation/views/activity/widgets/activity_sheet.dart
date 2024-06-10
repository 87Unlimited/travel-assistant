import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../common/widgets/icons/text_with_icon.dart';
import '../../../../../../common/widgets/section_heading.dart';
import '../../../../data/models/activity_model.dart';
import '../../../../data/models/trip_model.dart';
import '../../../../domain/services/location_services.dart';
import '../../../controllers/recommendation/recommendation_controller.dart';
import '../../trips/create_trip/create_trip_detail/widgets/activity_card.dart';
import '../../trips/create_trip/create_trip_detail/widgets/location_date_header.dart';

class ActivitySheet extends StatelessWidget {
  const ActivitySheet({
    super.key,
    required this.activity,
    required this.trip,
    required this.address,
  });

  final TripModel trip;
  final ActivityModel activity;
  final String address;

  @override
  Widget build(BuildContext context) {
    final recommendationController = Get.put(RecommendationController());
    recommendationController.getActivitiesRecommendationByActivity(activity);

    // Bottom sheet
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          child: Container(
            decoration: const BoxDecoration(
              color: CustomColors.whiteSmoke,
            ),
            child: ListView(
              controller: scrollController,
              children: [
                Padding(
                  padding: SpacingStyle.paddingWithNormalHeight,
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 5,
                          color: CustomColors.grey,
                        ),
                      ),

                      // Activity name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // Activity title
                        children: [
                          Text(
                            activity.name,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: CustomColors.primary),
                          ),

                          // Activity Location and rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Activity Location
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.location5,
                                    color: CustomColors.secondary,
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  Text(
                                    address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(color: Colors.blueGrey),
                                  ),
                                ],
                              ),

                              Spacer(),

                              // Activity Rating
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.star1,
                                    color: Colors.orange,
                                  ),
                                  const SizedBox(width: CustomSizes.spaceBtwItems / 2),
                                  Text(
                                    activity.rating.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .apply(color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: CustomSizes.spaceBtwItems),
                            ],
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Activity Duration
                          SectionHeading(title: "Recommended Staying Time", textColor: CustomColors.primary, showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                          Text(
                            activity.minimumDuration == "" ? '1 Hour' : activity.bookingLink,
                            style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.blueGrey),
                          ),

                          // Activity Description
                          SectionHeading(title: "Description", textColor: CustomColors.primary, showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems / 2),
                          Text(
                            activity.description,
                            style: Theme.of(context).textTheme.bodyLarge!.apply(color: CustomColors.grey),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 30,
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Activity Fee
                          Text(
                            activity.price == 0.0 ? "Free" :
                            activity.currencyCode + activity.price.toString(),
                            style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.secondary),
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          TextIconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: CustomSizes.iconMd,
                            ),
                            buttonText: 'Add to trip',
                            onPressed: () async {

                            },
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwSections),

                          // Nearby Activities recommendation
                          SectionHeading(title: "Nearby Activities", textColor: CustomColors.primary, showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems / 2),

                          Column(
                            children: [
                              // Obx(() {
                              //   if (recommendationController.activities.isEmpty) {
                              //     return Text("No Result.");
                              //   }
                              //   return recommendationController.isActivitiesLoading.value ? Center(
                              //     child: Column(
                              //       children: [
                              //         CircularProgressIndicator(),
                              //         const SizedBox(height: CustomSizes.spaceBtwItems),
                              //         Text(
                              //           "Loading...",
                              //           style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.darkGrey),
                              //         ),
                              //       ],
                              //     ),
                              //   ) : SizedBox(
                              //     height: 330,
                              //     child: ListView.builder(
                              //       shrinkWrap: true,
                              //       scrollDirection: Axis.horizontal,
                              //       itemCount: recommendationController.activities.length,
                              //       itemBuilder: (_, index) => ActivityCard(trip: trip, activity: recommendationController.activities[index]),
                              //     ),
                              //   );
                              // }),
                            ],
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwSections),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}