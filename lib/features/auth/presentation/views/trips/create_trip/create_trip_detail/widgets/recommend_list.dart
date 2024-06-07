import 'package:flutter/material.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_card_roundtrip.dart';

import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../controllers/recommendation/recommendation_controller.dart';

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

    return Container(
      child: Column(
        children: [
          SectionHeading(title: "Flights", textColor: CustomColors.primary, showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          Obx(() {
            return recommendationController.isLoading.value ? Center(
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
            return recommendationController.isLoading.value ? Center(
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
          ElevatedButton(onPressed: () => recommendationController.getActivitiesRecommendation(trip), child: Center(child: Text("TEST"),))
        ],
      ),
    );
  }
}