import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:travel_assistant/features/auth/data/models/trip_model.dart';
import 'package:travel_assistant/features/auth/domain/services/location_services.dart';
import 'package:intl/intl.dart';
import 'package:travel_assistant/core/util/constants/colors.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/bottom_sheet_create.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/horizontal_calendar.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/location_date_header.dart';

import '../../../../../../../common/widgets/appbar.dart';
import '../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../core/util/device/device_utility.dart';
import '../../../../../../../core/util/formatters/formatter.dart';
import '../../../../../../../core/util/helpers/helper_functions.dart';
import '../../../../../../../navigation_menu.dart';
import '../../../../controllers/trips/create_trip_detail_controller.dart';


class CreateTripDetailView extends StatelessWidget {
  const CreateTripDetailView({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripDetailController());
    final Completer<GoogleMapController> googleMapController = Completer<GoogleMapController>();
    final navController = Get.put(NavigationController());

    DateTime? firstDate = trip.startDate!.toDate();
    DateTime? lastDate = trip.endDate!.toDate();
    String dateTitle =
        "${CustomFormatters.yearMonthDay.format(firstDate!)} - ${CustomFormatters.yearMonthDay.format(lastDate!)}";
    controller.selectedDate = firstDate;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: false,
        leadingIcon: Iconsax.arrow_left,
        leadingOnPressed: () {
          navController.selectedIndex.value = 2;
          Get.to(NavigationMenu());
        },
        // Trip Name
        title: Text(
          trip.tripName,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: CustomColors.primary),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.origin,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(hintText: "Origin"),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        TextFormField(
                          controller: controller.destination,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(hintText: "Search by City"),
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var directions = await LocationServices().getDirections(
                        controller.origin.text.trim(),
                        controller.destination.text.trim(),
                      );
                      controller.goToPlace(directions['start_location']['lat'], directions['start_location']['lng'],);

                      controller.setPolyline(directions['polyline_decoded']);
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  markers: controller.markers,
                  polylines: controller.polylines,
                  polygons: controller.polygons,
                  initialCameraPosition: controller.kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController.complete(controller);
                  },
                  onTap: (point) {
                    controller.polygonLatLngs.add(point);
                    controller.setPolygon();
                  },
                ),
              ),
            ],
          ),
          // Draggable Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.7,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(30.0)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Padding(
                        padding: SpacingStyle.paddingWithNormalHeight,
                        child: Column(
                          children: [
                            const SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 5,
                                color: CustomColors.grey,
                              ),
                            ),
                            // Location And Date
                            LocationAndDateHeader(
                                location: trip.location, dateTitle: dateTitle),
                            const SizedBox(
                                height: CustomSizes.spaceBtwSections),

                            // Calendar
                            HorizontalCalendar(
                              selectedDate: controller.selectedDate!,
                              onDateChange: controller.handleDateChange,
                              initialDate: firstDate,
                            ),
                            const SizedBox(
                                height: CustomSizes.spaceBtwSections),

                            // Sign Up Button
                            TextIconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: CustomSizes.iconMd,
                              ),
                              buttonText: 'Add Location',
                              onPressed: () async {
                                _tripBottomSheet(context);
                              },
                            ),
                            const SizedBox(height: CustomSizes.spaceBtwItems),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Bottom sheet
  void _tripBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: DeviceUtils.getScreenHeight(context) * 0.5,
            width: DeviceUtils.getScreenWidth(context),
            child: const BottomSheetCreate(),
          );
        });
  }
}
