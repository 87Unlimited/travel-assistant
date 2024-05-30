import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/common/widgets/section_heading.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';

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

class FlightView extends StatelessWidget {
  const FlightView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FlightController());
    final flightServices = Get.put(FlightServices());

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
                child: ListView(
                  children: <Widget>[
                    Form(
                      key: controller.flightFormKey,
                      child: Column(
                        children: [
                          SectionHeading(title: "Flight Details", showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Location Name Form Field
                          Row(
                            children: [
                              // Start time
                              Expanded(
                                child: TextFormField(
                                  //controller: controller.endTime,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(FontAwesomeIcons.planeDeparture),
                                    labelText: "From",
                                  ),
                                ),
                              ),
                              const SizedBox(width: CustomSizes.spaceBtwItems),

                              Text(
                                "To",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),

                              const SizedBox(width: CustomSizes.spaceBtwItems),

                              // End Time
                              Expanded(
                                child: TextFormField(
                                  //controller: controller.endTime,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(FontAwesomeIcons.planeArrival),
                                    labelText: "To",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          // Start time and end time selection
                          Row(
                            children: [
                              // Start time
                              Expanded(
                                child: TextFormField(
                                  //controller: controller.endTime,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Iconsax.calendar),
                                    labelText: "Departure Date",
                                  ),
                                ),
                              ),
                              const SizedBox(width: CustomSizes.spaceBtwItems),

                              Text(
                                "To",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),

                              const SizedBox(width: CustomSizes.spaceBtwItems),

                              // End Time
                              Expanded(
                                child: TextFormField(
                                  //controller: controller.endTime,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Iconsax.calendar),
                                    labelText: "Return Date",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          TextField(
                            // controller: controller.attractionName,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.airline_seat_recline_extra_rounded),
                              labelText: "Class",
                            ),
                            onChanged: (value) {
                              // controller.placeAutoComplete(value);
                            },
                            onTap: () => controller.flightClassBottomSheet(context),
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          SectionHeading(title: "Passenger", showActionButton: false,),
                          const SizedBox(height: CustomSizes.spaceBtwItems),

                          TextField(
                            // controller: controller.attractionName,
                            readOnly: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.person),
                              labelText: "1 Adult",
                            ),
                            onChanged: (value) {
                              // controller.placeAutoComplete(value);
                            },
                            onTap: () => controller.flightPassengerBottomSheet(context),
                          ),
                          const SizedBox(height: CustomSizes.spaceBtwSections),

                          // Submit button
                          TextIconButton(
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: CustomSizes.iconMd,
                            ),
                            buttonText: 'Search',
                            onPressed: () async {
                              flightServices.fetchData("HKG", "SYD");
                            },
                          ),
                        ],
                      ),
                    ),
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