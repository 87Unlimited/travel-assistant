import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/device/device_utility.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:travel_assistant/features/auth/data/models/flight_model.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_view.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card.dart';

import '../../../../../common/widgets/appbar.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../controllers/trips/trip_controller.dart';

class TripView extends StatelessWidget {
  const TripView({super.key, this.flight});

  final FlightModel? flight;

  @override
  Widget build(BuildContext context) {
    final tripController = Get.put(TripController());
    tripController.fetchHomeViewTrips();

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "My Trips",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithNormalHeight,
          child: Column(
            children: [
              SectionHeading(title: "Upcoming Trips", showActionButton: false,),
              const SizedBox(height: CustomSizes.spaceBtwSections / 2),

              tripController.upcomingTrips.length >= 0 ? SizedBox(
                width: DeviceUtils.getScreenWidth(context),
                child: Obx(() =>
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: tripController.upcomingTrips.length,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) => const SizedBox(height: CustomSizes.spaceBtwItems),
                    itemBuilder: (context, index) => TripCardLong(
                      trip: tripController.upcomingTrips[index],
                      flight: flight,
                    ),
                  ),
                ),
              ) : Text("You have no upcoming trips yet! Create one now!", style: Theme.of(context).textTheme.titleMedium,),
              const SizedBox(height: CustomSizes.spaceBtwSections / 2),

              SectionHeading(title: "Past Trips", showActionButton: false,),
              const SizedBox(height: CustomSizes.spaceBtwSections / 2),

              Column(
                children: <Widget>[
                  SizedBox(
                    width: DeviceUtils.getScreenWidth(context),
                    child: Obx(() => ListView.separated(
                        shrinkWrap: true,
                        itemCount: tripController.pastTrips.length,
                        scrollDirection: Axis.vertical,
                        separatorBuilder: (context, index) => const SizedBox(height: CustomSizes.spaceBtwItems),
                        itemBuilder: (context, index) => TripCardLong(
                          trip: tripController.pastTrips[index],
                          flight: flight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: CustomSizes.spaceBtwSections),

                  flight == null ? SizedBox(
                    width: CustomSizes.buttonWidth,
                    height: CustomSizes.buttonHeight,
                    child: ElevatedButton(
                      onPressed: () => Get.to(CreateTripView()),
                      child: const Center(
                        child: Text('Create Trip'),
                      ),
                    ),
                  ) : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


