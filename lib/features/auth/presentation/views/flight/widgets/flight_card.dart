import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/custom_shapes/rounded_container.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/constants/shadows.dart';
import 'package:travel_assistant/core/util/constants/sizes.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../../common/widgets/icons/text_with_icon.dart';


class FlightCard extends StatelessWidget {
  const FlightCard({
    super.key,
    required this.flight,
  });

  final FlightModel flight;

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
                  TripCardTitleText(
                    title: flight.flightNumber,
                    textStyle: Theme.of(context).textTheme.headlineSmall!,
                  ),

                  TextWithIcon(
                    icon: Iconsax.clock,
                    title: "${flight.departureTime} - ${flight.arrivalTime}",
                    color: CustomColors.grey,
                    textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                  ),
                  SizedBox(height: CustomSizes.spaceBtwItems / 2,),

                  TextWithIcon(
                    icon: Iconsax.location,
                    title: flight.departureAirport,
                    color: CustomColors.grey,
                    textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                  ),
                  SizedBox(height: CustomSizes.spaceBtwItems / 2,),

                  TextWithIcon(
                    icon: Iconsax.location,
                    title: flight.arrivalAirport,
                    color: CustomColors.grey,
                    textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                  ),

                  TextWithIcon(
                    icon: Iconsax.location,
                    title: flight.flightNumber,
                    color: CustomColors.grey,
                    textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                  ),

                  TextWithIcon(
                    icon: Iconsax.location,
                    title: flight.airline,
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
