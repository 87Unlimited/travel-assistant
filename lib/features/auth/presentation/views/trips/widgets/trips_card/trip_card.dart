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
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card_title_text.dart';

import '../../../../../../../common/widgets/icons/text_with_icon.dart';
import '../../../../../../../core/util/formatters/formatter.dart';
import '../../../../../data/models/trip_model.dart';
import '../../../../controllers/trips/trip_controller.dart';
import '../../create_trip/create_trip_detail/create_trip_detail_view.dart';

class TripCardLong extends StatelessWidget {
  const TripCardLong({
    super.key,
    required this.trip,
    this.flight,
    this.onTap,
  });

  final TripModel trip;
  final FlightModel? flight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final tripController = Get.put(TripController());
    final formattedStartDate = CustomFormatters.yearAbbrMonthDay.format(trip.startDate!.toDate());
    final formattedEndDate = CustomFormatters.yearAbbrMonthDay.format(trip.endDate!.toDate());
    final dateRange = "${formattedStartDate.toString()} - ${formattedEndDate.toString()}";

    return Stack(
      children: [
        Container(
          width: DeviceUtils.getScreenWidth(context),
          height: 140,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            boxShadow: [ShadowStyle.horizontalCardShadow],
            borderRadius: BorderRadius.circular(CustomSizes.cardRadiusLg),
            color: dark ? CustomColors.darkGrey : Colors.white,
          ),
          child: Row(
            children: [
              // Image
              RoundedContainer(
                height: 120,
                padding: const EdgeInsets.all(CustomSizes.sm),
                backgroundColor: dark ? CustomColors.dark : CustomColors.white,
                child: Stack(
                  children: [
                    RoundedImage(
                      width: 100,
                      height: 100,
                      imageUrl: trip.image!,
                      applyImageRadius: true,
                      isNetworkImage: true,
                    ),
                  ],
                ),
              ),

              // Details
              SizedBox(
                width: 182,
                child: Padding(
                  padding: EdgeInsets.all(CustomSizes.sm),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TripCardTitleText(
                            title: trip.tripName,
                            textStyle: Theme.of(context).textTheme.headlineMedium!,
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems / 2,),

                          TextWithIcon(
                            icon: Iconsax.location5,
                            title: trip.location!.locationName,
                            color: CustomColors.secondary,
                            textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                          ),
                          SizedBox(height: CustomSizes.spaceBtwItems / 2,),
                        ],
                      ),

                      const Spacer(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWithIcon(
                              icon: Iconsax.calendar,
                              title: dateRange.toString(),
                              color: CustomColors.grey,
                              textStyle: Theme.of(context).textTheme.labelLarge!.apply(color: CustomColors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              flight != null ? tripController.addFlightToTrip(trip, flight!) :
              Get.to(() => CreateTripDetailView(trip: trip));
              },
            child: Container(
              decoration: const BoxDecoration(
                color: CustomColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(CustomSizes.cardRadiusMd),
                  bottomRight: Radius.circular(CustomSizes.cardRadiusLg),
                ),
              ),
              child: SizedBox(
                width: CustomSizes.iconLg * 1.2,
                height: CustomSizes.iconLg * 1.2,
                child: Center(
                  child: Icon(
                    flight == null ? Iconsax.calendar_edit : Iconsax.add_circle,
                    color: CustomColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
