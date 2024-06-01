import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/features/auth/domain/services/location_services.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_card.dart';
import 'package:travel_assistant/features/auth/presentation/views/flight/widgets/flight_search_form.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/device/device_utility.dart';
import '../../../../../../../../core/util/validators/validation.dart';
import '../../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../../common/widgets/appbar.dart';
import '../../../domain/services/flight_services.dart';
import '../../controllers/flight/flight_controller.dart';
import '../trips/create_trip/widgets/location_list_tile.dart';

class FlightView extends StatelessWidget {
  const FlightView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FlightController());
    final flightServices = Get.put(FlightServices());
    final locationServices = Get.put(LocationServices());

    String locationId = "";
    String locationName = "";

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Flight Searching",
          style: Theme.of(context).textTheme.headlineMedium!.apply(color: CustomColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithNormalHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: DeviceUtils.getScreenHeight(context),
                width: DeviceUtils.getScreenWidth(context),
                child: Column(
                  children: [
                    FlightSearchForm(),
                    const SizedBox(height: CustomSizes.spaceBtwSections),

                    Obx(() {
                      if (controller.flights.isEmpty) {
                        return Text("No result found");
                      } else {
                        return controller.isLoading.value ? Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              const SizedBox(height: CustomSizes.spaceBtwItems),
                              Text(
                                "Searching...",
                                style: Theme.of(context).textTheme.bodySmall!.apply(color: CustomColors.grey),
                              ),
                            ],
                          ),
                        ) : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: controller.flights.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: CustomSizes.spaceBtwItems),
                            itemBuilder: (context, index) => FlightCard(
                              flight: controller.flights[index],
                            ),
                          ),
                        );
                      }
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}