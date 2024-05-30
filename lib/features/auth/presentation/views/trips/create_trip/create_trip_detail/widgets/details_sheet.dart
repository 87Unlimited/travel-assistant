import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/location_card.dart';
import 'package:travel_assistant/features/auth/presentation/views/trips/create_trip/create_trip_detail/widgets/trip_stepper.dart';

import '../../../../../../../../common/widgets/button/text_icon_button.dart';
import '../../../../../../../../core/util/constants/colors.dart';
import '../../../../../../../../core/util/constants/sizes.dart';
import '../../../../../../../../core/util/constants/spacing_styles.dart';
import '../../../../../../../../core/util/formatters/formatter.dart';
import '../../../../../../data/models/trip_model.dart';
import '../../../../../controllers/trips/attraction_controller.dart';
import '../../../../../controllers/trips/create_trip_detail_controller.dart';
import 'horizontal_calendar.dart';
import 'location_date_header.dart';

class DetailsSheet extends StatelessWidget {
  const DetailsSheet({
    super.key,
    required this.trip,
  });

  final TripModel trip;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateTripDetailController());
    final attractionsController = Get.put(AttractionController());
    final createTripDetailController = Get.put(CreateTripDetailController());
    createTripDetailController.trip = trip;
    createTripDetailController.getMarker();

    DateTime? firstDate = trip.startDate!.toDate();
    DateTime? lastDate = trip.endDate!.toDate();
    String dateTitle =
        "${CustomFormatters.yearMonthDay.format(firstDate)} - ${CustomFormatters.yearMonthDay.format(lastDate)}";
    controller.selectedDate = firstDate;

    createTripDetailController.tripId = trip.tripId!;

    StepperType _type = StepperType.vertical;

    // Bottom sheet
    return DraggableScrollableSheet(
      initialChildSize: 0.2,
      minChildSize: 0.2,
      maxChildSize: 0.7,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
          child: Container(
            decoration: const BoxDecoration(
              color: CustomColors.whiteSmoke,
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
                          location: trip.location!.locationName,
                          dateTitle: dateTitle),
                      const SizedBox(height: CustomSizes.spaceBtwSections),

                      // Calendar
                      HorizontalCalendar(
                        selectedDate: controller.selectedDate!,
                        onDateChange: controller.handleDateChange,
                        initialDate: firstDate,
                      ),
                      const SizedBox(height: CustomSizes.spaceBtwSections),

                      // TripStepper(),
                      SizedBox(
                        height: 200,
                        child: Obx(() {
                          if (createTripDetailController.attractionsOfSingleDay.isEmpty) {
                            return Text("You have no activities yet.");
                          } else {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemCount: createTripDetailController
                                    .attractionsOfSingleDay.length,
                                scrollDirection: Axis.vertical,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: CustomSizes.spaceBtwItems),
                                itemBuilder: (context, index) => LocationCard(
                                  attraction: createTripDetailController.attractionsOfSingleDay[index],
                                  delete: () => createTripDetailController.deleteAttraction(createTripDetailController.attractionsOfSingleDay[index].attractionId),
                                ),
                            );
                          }
                        }),
                      ),
                      const SizedBox(height: CustomSizes.spaceBtwSections),

                      // Add Location Button
                      TextIconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: CustomSizes.iconMd,
                        ),
                        buttonText: 'Add Location',
                        onPressed: () async {
                          controller.tripBottomSheet(context, trip);
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
    );
  }
}
