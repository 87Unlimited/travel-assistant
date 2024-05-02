import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/device/device_utility.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/create_trip_detail_new.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/widgets/trips_card/trip_card.dart';

import '../../../../../common/widgets/appbar.dart';
import '../../../../../common/widgets/trip/trip_cards/trip_card_vertical.dart';
import '../../../../../core/util/constants/sizes.dart';
import '../../../../../core/util/constants/spacing_styles.dart';
import '../../controllers/trips/trip_controller.dart';
import 'create_trip/calendar_config.dart';
import 'create_trip/widgets/create_trip_form.dart';
import 'create_trip/widgets/range_date_picker.dart';

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final tripController = Get.put(TripController());

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "My Trips",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithNormalHeight,
          child: Column(
            children: [
              SectionHeading(title: "Past Trips", showActionButton: false,),
              const SizedBox(height: CustomSizes.spaceBtwSections / 2),

              SizedBox(
                width: DeviceUtils.getScreenWidth(context),
                height: DeviceUtils.getScreenHeight(context),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: tripController.homeViewTrips.length,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) => const SizedBox(height: CustomSizes.spaceBtwItems),
                  itemBuilder: (context, index) => TripCardLong(
                      trip: tripController.homeViewTrips[index]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


