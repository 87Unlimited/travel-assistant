import 'package:flutter/material.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_card_roundtrip.dart';

import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../controllers/recommendation/recommendation_controller.dart';
import 'activity_card.dart';

class RecommendList extends StatelessWidget {
  const RecommendList({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final recommendationController = Get.put(RecommendationController(trip: trip));
    recommendationController.getFlightRecommendation(trip);
    recommendationController.getActivitiesRecommendation(trip);

    return Container(
      child: Column(
        children: [
          SectionHeading(title: "Flights", textColor: CustomColors.primary, showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          //ActivityCard(),

          Obx(() {
            if (recommendationController.flight == FlightModel.empty()) {
              return Text("No Result.");
            }
            return recommendationController.isFlightsLoading.value ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.darkGrey),
                  ),
                ],
              ),
            ) : FlightCardRoundTrip(flight: recommendationController.flight.value);
          }),
          const SizedBox(height: CustomSizes.spaceBtwSections),

          SectionHeading(title: "Tours And Activities", textColor: CustomColors.primary, showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          Obx(() {
            if (recommendationController.activities.isEmpty) {
              return Text("No Result.");
            }
            return recommendationController.isActivitiesLoading.value ? Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: CustomSizes.spaceBtwItems),
                  Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.darkGrey),
                  ),
                ],
              ),
            ) : SizedBox(
                    height: 330,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendationController.activities.length,
                      itemBuilder: (_, index) => ActivityCard(trip: trip, activity: recommendationController.activities[index], controller: recommendationController,),
                    ),
                  );
          }),
          const SizedBox(height: CustomSizes.spaceBtwSections),
        ],
      ),
    );
  }
}