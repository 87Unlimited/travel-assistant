import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/core/util/helpers/helper_functions.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/widgets/create_trip_form.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/widgets/range_date_picker.dart';

import '../../../../../../common/widgets/appbar.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../navigation_menu.dart';
import '../../../../data/models/trip_model.dart';
import '../../../controllers/trips/create_trip_controller.dart';
import 'calendar_config.dart';
import 'create_trip_detail/create_trip_detail_view.dart';

class CreateTripView extends StatelessWidget {
  const CreateTripView({
    super.key,
    this.trip
  });

  final TripModel? trip;

  @override
  Widget build(BuildContext context) {
    final navController = Get.put(NavigationController());
    final controller = Get.put(CreateTripController());
    controller.clearTrip();

    if (trip != null) {
      controller.isTripExisted = true;
    }

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        leadingIcon: Iconsax.arrow_left,
        leadingOnPressed: () {
          navController.selectedIndex.value = 2;
          Get.off(NavigationMenu());
        },
        title: Text(
          controller.isTripExisted ? "Update Itinerary" : "Create Itinerary",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
        ),
        actions: [
          controller.isTripExisted ? IconButton(
            onPressed: () => controller.deleteTripWarningPopup(),
            icon: Icon(Icons.delete, color: Colors.red,),
          ) : SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              controller.isTripExisted ?
              CreateTripForm(trip: trip) : CreateTripForm(),
              const SizedBox(height: CustomSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
