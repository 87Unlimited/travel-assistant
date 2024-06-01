import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../common/widgets/circular_icon_stack.dart';
import '../../../../../../common/widgets/search_bar/location_search_bar.dart';
import '../../../../../../common/widgets/section_heading.dart';
import '../../../../../../core/util/constants/colors.dart';
import '../../../../../../core/util/constants/sizes.dart';
import '../../../../domain/services/flight_services.dart';
import '../../../../domain/services/location_services.dart';
import '../../../controllers/flight/flight_controller.dart';
import '../../trips/create_trip/widgets/location_list_tile.dart';


class FlightSearchForm extends StatelessWidget {
  const FlightSearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FlightController());
    final flightServices = Get.put(FlightServices());
    final locationServices = Get.put(LocationServices());

    return Form(
      //key: controller.flightFormKey,
      child: Column(
        children: [
          SectionHeading(title: "Flight Details", showActionButton: false,),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Location Name Form Field
          Row(
            children: [
              // Start time
              Expanded(
                child: TextField(
                  controller: controller.originController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.planeDeparture),
                    labelText: "From",
                  ),
                ),
              ),
              const SizedBox(width: CustomSizes.spaceBtwItems),

              Text("To", style: Theme.of(context).textTheme.titleLarge,),

              const SizedBox(width: CustomSizes.spaceBtwItems),

              // End Time
              Expanded(
                child: TextFormField(
                  controller: controller.destinationController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(FontAwesomeIcons.planeArrival),
                    labelText: "To",
                  ),
                ),
              ),
            ],
          ),
          // Row(
          //   children: [
          //     // Start time
          //     Expanded(
          //       child: LocationSearchBar(
          //         controller: controller.origin,
          //         leadingIcon: const Icon(FontAwesomeIcons.planeDeparture),
          //         hintText: "From",
          //         viewOnChanged: (value) {
          //           if (value != "") {
          //             locationServices.placeAutoComplete(value, "airport");
          //           } else {
          //             locationServices.placePredictions.clear();
          //           }
          //         },
          //         suggestionsBuilder:
          //             (BuildContext context, SearchController location) async {
          //           return Iterable<Widget>.generate(
          //               locationServices.placePredictions.length, (int index) {
          //             return LocationListTile(
          //               location:
          //               locationServices.placePredictions[index].description,
          //               onPressed: () async {
          //                 location.closeView(locationServices.placePredictions[index].description!);
          //                 controller.locationId = locationServices.placePredictions[index].placeId!;
          //                 controller.locationName = locationServices.placePredictions[index].description!;
          //                 locationServices.getIATACodeFromLocation(controller.locationId);
          //               },
          //               icon: FontAwesomeIcons.plane,
          //             );
          //           });
          //         },
          //       ),
          //     ),
          //     const SizedBox(width: CustomSizes.spaceBtwItems),
          //
          //     Text("To", style: Theme.of(context).textTheme.titleLarge,),
          //
          //     const SizedBox(width: CustomSizes.spaceBtwItems),
          //
          //     // End Time
          //     Expanded(
          //       child: LocationSearchBar(
          //         controller: controller.destination,
          //         leadingIcon: const Icon(FontAwesomeIcons.planeArrival),
          //         hintText: "To",
          //         viewOnChanged: (value) {
          //           if (value != "") {
          //             locationServices.placeAutoComplete(value, "airport");
          //           } else {
          //             locationServices.placePredictions.clear();
          //           }
          //         },
          //         suggestionsBuilder:
          //             (BuildContext context, SearchController location) async {
          //           return Iterable<Widget>.generate(
          //               locationServices.placePredictions.length, (int index) {
          //             return LocationListTile(
          //               location:
          //               locationServices.placePredictions[index].description,
          //               onPressed: () async {
          //                 location.closeView(locationServices.placePredictions[index].description!);
          //                 controller.locationId = locationServices.placePredictions[index].placeId!;
          //                 controller.locationName = locationServices.placePredictions[index].description!;
          //               },
          //               icon: FontAwesomeIcons.plane,
          //             );
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          // Departure Date and Return Date selection
          Row(
            children: [
              // Departure Date
              Expanded(
                child: TextField(
                  controller: controller.departureDateController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.calendar),
                    labelText: "Departure Date",
                  ),
                  readOnly: true,
                  onTap: () async => await controller.selectDate(context, controller.departureDateController),
                ),
              ),
              const SizedBox(width: CustomSizes.spaceBtwItems),

              Text("To", style: Theme.of(context).textTheme.titleLarge,),

              const SizedBox(width: CustomSizes.spaceBtwItems),

              // Return Date
              Expanded(
                child: TextFormField(
                  controller: controller.returnDateController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.calendar),
                    labelText: "Return Date",
                  ),
                  readOnly: true,
                  onTap: () async => await controller.selectDate(context, controller.returnDateController),
                ),
              ),
            ],
          ),
          const SizedBox(height: CustomSizes.spaceBtwItems),

          TextField(
            controller: controller.flightClassController,
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

          TextField(
            controller: controller.passengerController,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(FontAwesomeIcons.person),
              labelText: "Passenger",
            ),
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
              controller.fetchFlightResult();
            },
          ),
        ],
      ),
    );
  }
}

class itemCounter extends StatelessWidget {
  const itemCounter({
    super.key,
    required this.number,
    this.add,
    this.minus,
  });

  final VoidCallback? add, minus;
  final RxInt number;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          CircularIconStack(
            dark: false,
            icon: Icons.add,
            text: '',
            onTap: add,
          ),
          const SizedBox(width: CustomSizes.spaceBtwItems / 2),
          Obx(() => Text(
              number.value.toString(),
              style: Theme.of(context).textTheme.titleMedium!.apply(color: CustomColors.primary),
            ),
          ),
          const SizedBox(width: CustomSizes.spaceBtwItems / 2),
          CircularIconStack(
            dark: false,
            icon: Icons.remove,
            text: '',
            onTap: minus,
          ),
        ],
      ),
    );
  }
}